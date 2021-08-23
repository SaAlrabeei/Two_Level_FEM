% -This program is to solve Darcy-Forchhimer model, which is a non-linear
% PDE problem. This program finds the velucity (u) and the pressure (p)
% using Two-Level method. We use an iterative algrothim to solve the
% nonlinear system, then we use (Newton method ) to linearize the problem.
% -This program is done by Salah Alrabeei with alot of appriciated helps,
% advices from Prof. Faisal Fairag. 
% - Date: 20/01/2015
clear all
clc
tic

disp('--------------------------------------------------------------------');
num_refines=input('enter the number of refinements the fine mesh')
% if num_refines<2 
%     clc
%     num_refines=input('enter an integer number greater than 2')
% end
coarse
coars_mesh_tri=size(t,2);
coars_mesh_size=size(e,2)/4
t_c=t;
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% generate the pressure at the triangules 
np = size(p,2);
nt = size(t,2);
n=2*nt;

[p e t]=num_ref(num_refines+c_ref);
    fine_mesh_tri=size(t,2);
fine_mesh_size=size(e,2)/4

num_son_tri=(size(e,2)/4)^2;
coars_mesh_size=size(t_c,2);

for k=1:num_refines
    for i=1:coars_mesh_size;
    for j=0:3
s2c(j+1,i)=i+num_son_tri*j;
ufx(s2c(j+1,i))=vx(i);
ufy(s2c(j+1,i))=vy(i);
    end
    end
coars_mesh_size=4*coars_mesh_size;
vx=ufx;
vy=ufy;
end

u=zeros(2*length(ufx),1);
u(1:2:end)=vx;
u(2:2:end)=vy;

% Call the Two-level ( second step) fine mesh
fine %lauch 2nd level 
      duration=toc;
    fprintf(' ||Norm_P0||     ||Norm_P1||      ||Norm_u0||   CPU-Time \n')
fprintf('   %1.4f             %1.4f             %1.4f          %1.4f        \n',norp0,normp1,normu,duration)