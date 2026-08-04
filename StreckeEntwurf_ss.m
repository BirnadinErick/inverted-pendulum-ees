%% Inv Pend SIMO Sys in Zustandraumdarstellung
% all metrics in SI Units
% src: https://ctms.engin.umich.edu/CTMS/index.php?example=InvertedPendulum&section=SystemModeling

%% Parameters
M = 0.5; % Wagon mass
m = 0.2;
b = 0.1; % coefficient of viscosity
I = 0.006; % MoI
g = 9.81;
l = 0.3;

%% Sys Matrices
p = I*(M+m)+M*m*l^2; %denominator for the A and B matrices

A = [0      1              0           0;
     0 -(I+m*l^2)*b/p  (m^2*g*l^2)/p   0;
     0      0              0           1;
     0 -(m*l*b)/p       m*g*l*(M+m)/p  0];
B = [     0;
     (I+m*l^2)/p;
          0;
        m*l/p];
C = [1 0 0 0;   % x
     0 0 1 0];  % phi
D = [0;
     0];

%% system construction
states = {'x' 'x_dot' 'phi' 'phi_dot'};
inputs = {'u'};
outputs = {'x'; 'phi'};

sys_ss = ss(A,B,C,D, ...
    'statename',states,'inputname',inputs,'outputname',outputs ...
    );