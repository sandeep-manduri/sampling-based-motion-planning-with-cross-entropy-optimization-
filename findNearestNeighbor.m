function [nnId] = findNearestNeighbor(treenodes, randnode)
% Find the node that is closest to the random node. Use the euclidean
% distance as a metric.

min = norm(treenodes(1).coord-randnode);
min_id = 1;
for i = 1:length(treenodes)
    p = treenodes(i).coord;
    dis = norm(p-randnode);
    if(dis<min)
        min = dis;
        min_id = i;
    end
end
nnId = min_id;
end