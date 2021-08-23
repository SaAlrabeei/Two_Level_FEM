function A = Generate_Mat_A(p,t,u,mu,rho,Beta,K_inv)
nt=size(t,2);
n=2*nt;
A=sparse(n,n);

for k=1:nt    
    loc2glb=t(1:3,k);
    x=p(1,loc2glb);
    y=p(2,loc2glb);
    area=polyarea(x,y);
    alpha=alpha1(u(2*k-1),u(2*k),mu,rho,Beta,K_inv);

    term=alpha*area;
    A(2*k-1,2*k-1)=term;
    A(2*k,2*k)=term;
end