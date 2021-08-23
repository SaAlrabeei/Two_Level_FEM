function F2 = generate_b_vec(p,t,bf)
% b = inline(']x^2.*y;2*x]');
np = size(p,2);
nt = size(t,2);
n=2*nt;
m=np;
F2 = zeros(m,1);
for K = 1:nt
    loc2glb =t(1:3,K);
    x = p(1,loc2glb);
    y = p(2,loc2glb);
    area = polyarea(x,y);
    vf=[bf(x(1),y(1));bf(x(2),y(2));bf(x(3),y(3))]*area; 
    F2(loc2glb)= F2(loc2glb)+vf;
end