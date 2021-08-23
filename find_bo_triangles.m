function [horz_triangles,vert_triangles] = find_bo_triangles(e,t);
t=t(1:3,:);
n_bo =size(e,2);
for i=1:n_bo
  bo_trig(i) = find(sum(t==e(1,i))==1 & sum(t==e(2,i))==1);
end
horz_triangles =bo_trig(1:2:end);
vert_triangles =bo_trig(2:2:end);

