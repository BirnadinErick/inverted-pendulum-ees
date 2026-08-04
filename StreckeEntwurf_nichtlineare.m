% =========================================================================
% Nonlinear Equations of Motion (Upright Inverted Pendulum on a Cart)
% =========================================================================
%
% 1) (M + m)*x_ddot + b*x_dot - m*l*theta_ddot*cos(theta) + m*l*(theta_dot^2)*sin(theta) = F
% 2) l*theta_ddot - x_ddot*cos(theta) - g*sin(theta) = 0
%
% Where:
%   M          = Cart mass
%   m          = Pendulum point mass
%   l          = Length of pendulum rod
%   b          = Cart rail friction coefficient
%   g          = Gravity acceleration constant
%   F          = Input force applied to the cart
%   x_dot      = Cart velocity
%   x_ddot     = Cart acceleration
%   theta      = Pendulum angle (0 rad = upright, positive counter-clockwise)
%   theta_dot  = Pendulum angular velocity
%   theta_ddot = Pendulum angular acceleration
% =========================================================================

%% Parameters
M = 0.5; % Wagon mass / kg
m = 0.2; % Pendulum point-mass / kg
l = 0.3;  % Length of pendulum rod / m
b = 0.1;  % Cart rail friction coefficient
g = 9.81; % ms-2
F = 0; % input / N

%% init conditions
theta_init = 0; % deg
x_init = 0; % m