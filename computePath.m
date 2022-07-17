function [path] = computePath(nbr, rnd, steps)
% Compute a linear joint space path between the nearest neighbour and the
% random node with the specified number of steps.
xs = linspace(nbr(1),rnd(1),steps);
ys = linspace(nbr(2),rnd(2),steps);
path = [xs;ys];
end