  tic

clc
  % load mesh_sample
c_ref=3;
[p,e,t]=num_ref(c_ref);
nt=size(t,2);   n=2*nt;

% -----------------------
Beta=1;  mu=1;   rho=1;   K_inv=1;  Max_itr=20;  tolr=1.e-10;
pf=inline('x.^3+y.^3','x','y');    uf=inline('[2*y.*(1-x.^2);-2*x.*(1-y.^2)]');
ufh=inline('2*y.*(1-x.^2)','x','y');
ufv=inline('-2*x.*(1-y.^2)','x','y');
dpx=inline('3.*x.^2','x','y'); dpy=inline('3.*y.^2','x','y');
gradpf = inline('[3*x.^2;3*y.^2]'); % grad_p
bf=inline('0','x','y');  % bf = div( u )
gf=inline('0','x','y'); 
pressure=zeros(size(p,2),1);  u=ones(n,1);
m=length(pressure);
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% exact solutions 
 exactpressure = pf(p(1,:),p(2,:)); 

dpxx=f_at_center(p,t,dpx); % Px of exact pressure
dpyy=f_at_center(p,t,dpy);% Py of exact pressure
 uhe=f_at_center(p,t,ufh);% velucity of the exact, two cols
 uve=f_at_center(p,t,ufv);
 B = Generate_Mat_B(p,t);
 b_vec = generate_b_vec(p,t,bf);
 F1= generate_vec_f(p,t,Beta,mu,rho,K_inv,pf,uf,gradpf); 
for iter=1:Max_itr
    
    [px,py]=pdegrad(p,t,pressure);
   
   J =Jacobian(p,t,u,mu,rho,Beta,K_inv,B);
   b=rhs(pressure,u,p,t,px,py,F1,b_vec,Beta);
   % -----  Modify the matrix B -------
   J5 = J(n+5,:);  J(n+5,:)=[]; b(n+5)=[]; J(:,n+5)=[];
   
% [up,b]=impose_boundary_condition(up,B,b,t,e,gf);    
up = J\b;      
      up=[up(1:n+4);0;up(n+5:end)];
   u=up(1:n)+u;
   pressure=up(n+1:m+n)+pressure;

error=norm(pressure'-exactpressure);
residual=(norm(b(n+1:n+m-1)));
 if (error< tolr); iter;
     break;end   
end
%    norm_u=norm(Ui-u);
 vel = up(1:n);
 vx = vel(1:2:n);
 vy = vel(2:2:n);
%     pressure = [up(n+1:n+4);0;up(n+5:n+m)];
     integral_of_pressure = int_pressure(p,t,pressure);
     pressure = pressure - integral_of_pressure;  
%     norm_p=norm(Pi-pressure);
%     
%   
% 
%     
%     
     
% norm_p=norm(Pi-pressure);
%     fprintf('%d    %0.5g   %.5g    %0.5g \n',iter , norp0, normp1,normu)
%    
% end

 

px; % the approx pressure of px
py; % the approx pressure of py
 norpx=norl22(p,t,px-dpxx);
 norpy=norl22(p,t,py-dpyy);
 p_exact=pf(p(1,:),p(2,:));
 norp0=norl2(p,t,p_exact-pressure');
 normp1=sqrt(norpx.^2+norpy.^2+norp0.^2);
 noruh=norl22(p,t,uhe-vx');
 noruv=norl22(p,t,uve-vy');
 normu=sqrt(noruh.^2+noruv.^2);

% residual=norm(b-At*up)
 
% vel; % velucity of the approx sol
% vx; % velucity at X-axis of the approx sol
% vy;% velucity at y-axis of the approx sol

 

%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% ploting codes 

 xx=-1:0.01:1;   yy=-1:0.01:1;
     pressure_matrix=tri2grid(p,t,pressure,xx,yy); 
  figure;    mesh(xx,yy,pressure_matrix); 
 title(['The approx solution in the coarse mesh, when H=1/' num2str(length(e)/4)])
% %  hold on
%  %  contour(pressure_matrix,100)
%   [X Y] = meshgrid(xx,yy); 
%   title(['The approx solution in the coarse mesh, when h=1/' num2str(length(e)/4)])
%   figure;  exactp = pf(X,Y);  mesh(xx,yy,exactp);  % contour(exactp,100)
%   title(['The exact solution in the coarse mesh, when h=1/' num2str(length(e)/4)])
duration=toc;
% fprintf(' ||Norm_P0||     ||Norm_P1||      ||Norm_u0||   CPU-Time \n')
%fprintf('   %1.4f             %1.4f             %1.4f          %1.4f        \n',norp0,normp1,normu,duration)