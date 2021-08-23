function [p,e,t]=num_ref(n)
g=[ 2  2  2  2;
    -1  1  1  -1; 
    1  -1  1  -1;   % g='squareg';  
    -1  1  -1  1;   % The [-1,1]x[-1,1] square
    -1  1  1  -1; 
    1  1  1  1;
    0  0  0  0 ];
 [p,e,t]=initmesh(g,'Hmax',2);
for i=1:n
   [p,e,t]=refinemesh(g,p,e,t);

end


 
end
