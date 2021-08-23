function norml2=norl2(p,t,u)
nt=size(t,2);
nor=0;
for k=1:nt
    loc2glb=t(1:3,k);
    x=p(1,loc2glb);
    y=p(2,loc2glb);
    U2=u(loc2glb).^2;
    area=polyarea(x,y);
    term=sum(U2)*area/3;
    nor=nor+term;
end
norml2=sqrt(nor);
end

    