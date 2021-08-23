function [alpha_Inv]=alpha1(z1,z2,mu,rho,Beta,K_inv)
%=alpha1(z)

%  u=inline('x+y')

% mu=1;
% segma=1;
% K_inv=1;
% Beta=1;

alpha_Inv=mu/rho*K_inv+Beta/rho*sqrt(z1^2+z2^2);
 end
