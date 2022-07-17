clear all;close all;clc
format long;

%arm lengths
par.a1 = 1;
par.a2 = 0.5;

%% Problem setup.

qinit = [0.8 -1];
qgoal = [-0.8 0];

enable_obstacle = true;

phi1_range = [-0.8 0.8];%[initial_angle final_angle]
phi2_range = [-1 1];%[initial_angle final_angle]
%% RRT Implementation
% create node structure for initial and goal node
initNode.coord = qinit;
initNode.parent = 0;
goalNode.coord = qgoal;
goalNode.parent = [];

MAX_NODES = 1000;
num_path_steps = 10;

clc;
[path_js]= rrt_star(par, initNode, goalNode, MAX_NODES, num_path_steps, phi1_range, phi2_range);

if isempty(path_js)
    disp('Failure!');
else
    disp('Success!!');
end
%% Create trajectory from path and visualize
qtrajx = [];
qtrajy = [];
[eef_coords] = getEndEffectorPositions(par,path_js);
prev = path_js(:,1);
for i = 2:length(path_js)
    nex = path_js(:,i);
    tempx = linspace(prev(1),nex(1),50);
    qtrajx = [qtrajx,tempx];
    tempy = linspace(prev(2),nex(2),50);
    qtrajy = [qtrajy,tempy];
    prev = nex;      
end 

qtraj = [qtrajx;qtrajy];
t = size(qtraj,2);
tVec = 1:1:t;
body_animate(tVec,qtraj',par, eef_coords',enable_obstacle);
%dt = 0.1;
%t = (size(path_js,2) - 1) - dt;
%tVec = 0:dt:t;
%qtraj = ones(numel(tVec),1)*qinit;% Write your code to show the variation in qtraj as the states change

%[eef_coords] = getEndEffectorPositions(par,path_js);%Write your code

%body_animate(tVec,qtraj(:,1:2),par,eef_coords,enable_obstacle);

%%
path_js
%%