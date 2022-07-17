function [reachedGoal] = goalReached(rNode,gNode,tol)
% Check if the goal was reached within the joint space tolerance of 0.01.
% That is, if a certain tree node is within a circle of radius 0.01
if(norm(rNode-gNode)<=tol)
reachedGoal = 1;
else 
reachedGoal = 0;
end