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

goal_euclid = getEndEffectorPositions(par,qgoal');
start_euclid = getEndEffectorPositions(par,qinit');
%% RRT Implementation
% create node structure for initial and goal node
initNode.coord = qinit;
initNode.parent = 0;
goalNode.coord = qgoal;
goalNode.parent = [];

MAX_NODES = 1000;
num_path_steps = 10;

clc;

delta = 0.1;
num_traj = 500;
path_js = [];
costs = [];
alphas = [0.5,0.3,0.2];
mus = [0.3,0.1;0.4,0.3:0.1,0.7]; % 3 component GMM mean vectors initialised to random 

for i1 = 1:3
   sigmas(:, :, i1) = eye(2); % 3 covariance matrices randomly initialised
end
total_costs = [];
for j = 1:6
    j
    hold on
    plot(goal_euclid(1),goal_euclid(2),'o','MarkerSize',25,'MarkerFaceColor','black')
    plot(start_euclid(1),start_euclid(2),'o','MarkerSize',25,'MarkerFaceColor','black')
    ax = gca;
    path_js = [];
    costs = [];
    for i = 1:num_traj
    [nw_path]= rrt_star(par, initNode, goalNode, MAX_NODES, num_path_steps, phi1_range, phi2_range,alphas,mus,sigmas);
    if(length(nw_path)<11)
        continue
    end
    nw_eef = getEndEffectorPositions(par,nw_path);
    plot(nw_eef(1,:),nw_eef(2,:))
    cst = path_cost(nw_eef);
    costs = [costs,cst];
    length(nw_eef);
    train = randsample(1:length(nw_eef),10);
    path_js = [path_js;[nw_path(:,train)]];
    end
    exportgraphics(ax,sprintf('zsampled trajs 2 comps %d.jpg',j))
    hold off
    cla reset
    length(costs);
    elite_num = fix(length(costs)*delta);
    if(elite_num<1)
        continue
    end
    [cur_cos,X] = get_elite_list(path_js,elite_num,costs);
    %cur_cos
    total_costs = [total_costs,cur_cos];
    [alphas,mus,sigmas] = gmm_fit(X,3);
end

