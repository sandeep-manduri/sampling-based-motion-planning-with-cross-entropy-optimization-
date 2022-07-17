function [randNode] = biasSampleRandomNode(phi1,phi2,goal,bias,alphas,mus,sigmas)
% Uniformly randomly sample a node of the tree in the specified joint angle
% ranges. A node is a vector of size n x 1 which contains valid values of
% corresponding joint angles in the specified range.
% Hint: Use the "rand" function.
prob = rand;
if(prob<=bias)
    randNode = goal;
else
s = RandStream('mlfg6331_64');
yyy = randsample(s,[1,2,3],1,true,alphas);
randNode = mvnrnd(mus(yyy,:),sigmas(:,:,yyy));

end