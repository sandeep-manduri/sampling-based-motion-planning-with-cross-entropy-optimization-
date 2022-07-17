function [randNode] = sampleRandomNode(phi1,phi2)
% Uniformly randomly sample a node of the tree in the specified joint angle
% ranges. A node is a vector of size n x 1 which contains valid values of
% corresponding joint angles in the specified range.
% Hint: Use the "rand" function.
p1 = unifrnd(phi1(1),phi1(2));
p2 = unifrnd(phi2(1),phi2(2));
randNode = [p1,p2];

end