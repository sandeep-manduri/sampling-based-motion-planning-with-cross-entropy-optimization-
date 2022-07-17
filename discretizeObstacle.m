function [obs_coords] = discretizeObstacle(obs_range, obs_discretization_steps)
y_bin = linspace(obs_range(1,2),obs_range(2,2),obs_discretization_steps);
obs_coords =  [obs_range(1,1)*ones(1,size(y_bin,2)), obs_range(2,1)*ones(1,size(y_bin,2));y_bin, y_bin];