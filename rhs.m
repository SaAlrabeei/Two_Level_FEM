function [Fj]=rhs(pressure,u,p,t,px,py,F1,b_vec,Beta)
%This function is to find the RHS of the Newton formula


  mu=1;   rho=1;   K_inv=1;
m=length(pressure);
n=length(u);
Fj1=zeros(n,1);
Fj2=zeros(m,1);
Fj=zeros(n+m,1);
nt=size(t,2);
for k=1:nt
    jo=2*k-1; je=2*k;
    loc2glb=t(1:3,k);
    x=p(1,loc2glb); y=p(2,loc2glb); xc=sum(x)/3; yc=sum(y)/3; % make sure what to choose
    area=polyarea(x,y);
    
    abslu= rho/mu*K_inv + Beta/mu*sqrt(u(2*k-1).^2+u(2*k).^2);
    term1x=u(2*k-1)*abslu*area; % I deleted 3
    term1y=u(2*k)*abslu*area;
    term2x=px(k)*area;
    term2y=py(k)*area;
    Fj1(jo)=Fj1(jo)+term1x+term2x;
    Fj1(je)=Fj1(je)+term1y+term2y;
end
Fj1=-Fj1+F1; % This is F_j = (C|u|,u,phi)+(grad_p,phi)-(f,phi) , where j=1,2,...,n 

% rhs of the 2nd equation F_j+1 

for k=1:nt
    
    loc2glb=t(1:3,k);
    x=p(1,loc2glb); y=p(2,loc2glb);
    [area,b,c]=Gradients(x,y);
     jo=2*k-1; je=2*k;
     u1=u(jo); u2=u(je);
     term=(b*u1+c*u2)*area;
    Fj2(loc2glb)=Fj2(loc2glb)+term; % how to insert the values to the   
end
 Fj2=-Fj2-b_vec; % temperorary 
Fj=[Fj1;Fj2];
end


    
    