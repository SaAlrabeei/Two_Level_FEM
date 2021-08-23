function integral_of_pressure = int_pressure(p,t,pressure)
integral_of_pressure = 0;
nt = size(t,2);
for k=1:nt
    node = t(1:3,k);
    x = p(1,node);
    y = p(2,node);
    sumpressure = sum(pressure(node));
    area = polyarea(x,y);
    integral_of_pressure = integral_of_pressure + sumpressure*area/3;
end
end