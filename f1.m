function ff=f1(x,y,Beta,mu,rho,K_inv,pf,uf,gradpf)
u = uf(x,y);
p = pf(x,y);
grad_p = gradpf(x,y);
norm_u = norm(u);
ff = (mu/rho) * K_inv * u + (Beta/rho) * norm_u * u + grad_p;
end