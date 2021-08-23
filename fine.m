
nt=size(t,2);   n=2*nt;
% -----------------------
Beta=1;  mu=1;   rho=1;   K_inv=1;  Max_itr=500;  tolr=1.e-5;
pf=inline('x.^3+y.^3','x','y');    uf=inline('[2*y.*(1-x.^2);-2*x.*(1-y.^2)]'); 
dpx=inline('3.*x.^2','x','y'); dpy=inline('3.*y.^2','x','y');
gradpf = inline('[3*x.^2;3*y.^2]'); % grad_p
bf=inline('0','x','y');  % bf = div( u )
gf=inline('0','x','y'); 
 pressure=zeros(size(p,2),1); 
% u=ones(n,1);
   A = Generate_Mat_A(p,t,u,mu,rho,Beta,K_inv);  n=size(A,1);
   B = Generate_Mat_B(p,t);
   b_vec = generate_b_vec(p,t,bf);
   F1= generate_vec_f(p,t,Beta,mu,rho,K_inv,pf,uf,gradpf); 
   % -----  Modify the matrix B -------
   B5 = B(5,:);  B(5,:)=[];  m=size(B,1);  b_vec(5)=[]; 
 
   At=[A,B';B,sparse(m,m)];    b = [F1;b_vec];
   % -----  impose boundary cond  -------
%    [At,b]=impose_boundary_condition(At,B,b,t,e,gf);
   Ui=u;   Pi=pressure;
   up = At\b;    u=up(1:n);    norm_u=norm(Ui-u);
   residual=norm((b-At*up));
   pressure = [up(n+1:n+4);0;up(n+5:n+m)];
   integral_of_pressure = int_pressure(p,t,pressure);
   pressure = pressure - integral_of_pressure;   
%    norm_p=norm(Pi-pressure);
%    fprintf('%d  %0.5g  %0.5g \n',iter , norm_p, norm_u)
%    if (norm_u< tolr && norm_p<tolr);break;end
    xx=-1:0.01:1;   yy=-1:0.01:1;
   pressure_matrix=tri2grid(p,t,pressure,xx,yy); 
   figure;    mesh(xx,yy,pressure_matrix);  %  contour(pressure_matrix,100)
  title(['The approx solution in the fine mesh, when h=1/' num2str(length(e)/4)])
%[X Y] = meshgrid(xx,yy); 
%f%ig%ure;  exactp = pf(X,Y);  mesh(xx,yy,exactp);  % contour(exactp,100)

dpxx=f_at_center(p,t,dpx); % Px of exact pressure
dpyy=f_at_center(p,t,dpy);% Py of exact pressure


 uhe=f_at_center(p,t,ufh);% velucity of the exact, two cols
 uve=f_at_center(p,t,ufv);
 
[px,py]=pdegrad(p,t,pressure);

px; % the approx pressure of px
py; % the approx pressure of py
norpx=norl22(p,t,px-dpxx);
norpy=norl22(p,t,py-dpyy);
p_exact=pf(p(1,:),p(2,:));
norm(p_exact-pressure')/(size(e,2)/4)^2;
norp0=norl2(p,t,p_exact-pressure');
normp1=sqrt(norpx.^2+norpy.^2+norp0.^2);
noruh=norl22(p,t,uhe-ufx);
noruv=norl22(p,t,uve-ufy);
normu=sqrt(noruh.^2+noruv.^2);


