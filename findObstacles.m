function [obsList] = findObstacles(eef_coords,obs_coords)
% Find the combinations of joint angles which would lead to the
% end-effector colliding with the obstacle or violate the 0.1m clearance
% constraint.

obsList = [];
for i = 1:length(obs_coords)
    cur_obs = obs_coords(:,i);
    for j = 1:length(eef_coords)
        cur_eef = eef_coords(:,j);
        distance = norm(cur_obs-cur_eef);
        if(distance<0.1)
            obsList=[obsList,j];
            
        end
    end
end
length(obsList);
obsList = unique(obsList);

for i = 1:length(eef_coords)
    cur_eef = eef_coords(:,j);
    if(cur_eef(2)<0)
        obsList = [1];
        break
    end
end
        