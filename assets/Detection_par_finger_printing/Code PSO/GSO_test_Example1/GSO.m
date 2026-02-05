%-----------------GSO.m---------------------------------------------------
% Glowworm swarm optimization (GSO)
% Developed by K.N. Kaipa and D. Ghose in 2005
% This is the main front-end code
%-------------------------------------------------------------------------
clc; clear; close all;
tic
global n m A_init A Ell gamma ro step1 r_d r_s ...
beta r_min n_t Ave_d bound
m = 2; % No. of dimensions
% Parameter initialization
%-----------------------------------------------
n = 100; % No. of agents
r_s = 3; % Sensor range
r_d = r_s*ones(n,1); % Local decision range
r_min = 0; % Threshold decisin range
gamma = 0.6; % Luciferin enhancement constant
ro = 0.4; % Luciferin decay constant
step1 = 0.03; % Distance moved by each glowworm when a
% decision is taken
beta = 0.08; % decision range gain
n_t = 5; % Desired no. of neighbors
% Initialization of variables
%----------------------------------------------------
bound = 3; % Parameter specifying the workspace range
DeployAgents; % Deploy the glowworms randomly
Ell = 5*ones(n,1); % Initialization of Luciferin levels
j = 1; % Iteration index
iter = 250; % No. of iterations
Ave_d = zeros(iter,1); % Average distance
% Main loop
%----------------------------------------------
while (j <= iter)
UpdateLuciferin; % Update the luciferin levels at glowworms’
% current positions
Act; % Select a direction and move
for k = 1 : n % store the state histories
agent_x(k,j,:) = A(k,1);
agent_y(k,j,:) = A(k,2);
end
j = j + 1;
j % Display iteration number
end
toc % Display the total computation time
% Plots
%-------------------------------------------------
figure(1); % Plot of trajectories of glowworms from their
% initial locations to final locations
plot(A_init(:,1),A_init(:,2),'x');
xlabel('X'); ylabel('Y');
hold on;
DefineAxis;
for k = 1 : n
plot(agent_x(k,:,:),agent_y(k,:,:));
end
DefineAxis;
grid on;
hold on;
plot([-0.0093;1.2857;-0.46], [1.5814;-0.0048;-0.6292],'ok');
figure(2); % Plot of final locations of glowworms
plot(A(:,1),A(:,2),'.');
DefineAxis;
grid on;
hold on;
plot([-0.0093;1.2857;-0.46], [1.5814;-0.0048;-0.6292],'ok');