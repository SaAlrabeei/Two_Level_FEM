 function pressure1=pressure_tri2node(p,t,pressure_at_tri)
np=size(p,2);
tt=t(1:3,:);
for i=1:np
    v=tt==i;
    v=sum(v);
    v=find(v);
%     pressuer_at_nod(i)=sum(pressure_at_tri(v))/length(v);
     pressuer_at_nod(i)=sum(pressure_at_tri(v))/length(v);
     

end
pressure1=pressure_at_tri;
 end


    