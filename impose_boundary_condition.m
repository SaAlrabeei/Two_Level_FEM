function [At,b]=impose_boundary_condition(At,B,b,t,e,gf);
m=size(B,1);
n=size(B,2);
[horz_triangles,vert_triangles] = find_bo_triangles(e,t);
% ------ impose the second equation n.u = g -----

nh = length(horz_triangles);
nv = length(vert_triangles);
for i=1:nh
    irow = 2*horz_triangles(i);
    At(irow,:) = sparse(1,n+m);
    At(:,irow) = sparse(n+m,1);
    b(irow) = 0;%gf(p(1,irow),p(2,irow));
    At(irow,irow) = 1;
end

for i=1:nv
    irow = 2*vert_triangles(i)-1;
    At(irow,:) = sparse(1,n+m);
    At(:,irow) = sparse(n+m,1);
    b(irow) = 0;%gf(p(1,irow),p(2,irow));
    At(irow,irow) = 1;
end
end

