function fun_at_center=f_at_center(p,t,u)
nt=size(t,2);
nor=0;
for k=1:nt
    loc2glb=t(1:3,k);
    x=p(1,loc2glb);
    y=p(2,loc2glb);
    xc=mean(x);
    yc=mean(y);
    uc(k)=u(xc,yc);
end
fun_at_center=uc;
    