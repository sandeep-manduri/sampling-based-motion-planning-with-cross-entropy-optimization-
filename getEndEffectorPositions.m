function [xy_eef] = getEndEffectorPositions(par, gridCoords)
xy_eef = [];
for  i = 1:numel(gridCoords(1,:))
    xy_eef(:,i) = [-sin(gridCoords(1,i))*(par.a1)+sin(gridCoords(2,i))*(par.a2);cos(gridCoords(1,i))*(par.a1)-cos(gridCoords(2,i))*(par.a2)];
    
end 
end