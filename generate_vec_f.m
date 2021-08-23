function F1 = generate_vec_f(p,t,Beta,mu,rho,K_inv,pf,uf,gradpf)
np = size(p,2);
nt = size(t,2);
n=2*nt;
m=np;
F1 = sparse(n,1);
for k = 1:nt
   loc2glb = t(1:3,k);    x = p(1,loc2glb);   y = p(2,loc2glb);
   xc=mean(x);  yc=mean(y);
   area = polyarea(x,y);
   fv=f1(xc,yc,Beta,mu,rho,K_inv,pf,uf,gradpf);
   row1=2*k-1;   row2=2*k;
   integ1=fv(1)*area;
   integ2=fv(2)*area;
   F1(row1)=integ1;
   F1(row2)=integ2;
end
