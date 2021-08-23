function B = Generate_Mat_B(p,t)
np = size(p,2);
nt = size(t,2);
n=2*nt;
m=np;
B = sparse(m,n);

for k = 1:nt
    loc2glb = t(1:3,k); % local-to-global map
    x = p(1,loc2glb); % node x-coordinates
    y = p(2,loc2glb); % node y-
    [area,b,c] = Gradients(x,y);
    col1=2*k-1;
    col2=2*k;
    B(loc2glb,col1)=b'*area; % it was -b'*area %Salah I dont know why it is supposed to be negative 
    B(loc2glb,col2)=c'*area; %it was -c'*area
end

% rank(full(B(2:41,1:127)))