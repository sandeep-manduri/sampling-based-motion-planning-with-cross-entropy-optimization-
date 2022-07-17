function [nodes,tree] = near(treeNodes,new,r,cur_cost,par)
nodes = [];
%global treeNodes
best = cur_cost;
%length(treeNodes)
%new
for i = 1:length(treeNodes)-1
    cur = treeNodes(i).coord;
    new_coord = treeNodes(new).coord;
    %nnn = getEndEffectorPositions(par, new_coord');
    %ccc = getEndEffectorPositions(par, cur');
    ccc = cur;
    nnn = new_coord;
    dist = norm(nnn-ccc);
    if(dist<r)
        nodes = [nodes,i];
        val = dist + treeNodes(i).val;
        if(val<best)
            best = val;
            treeNodes(new).parent = i;
            %treeNodes(new).par
            treeNodes(new).val = best;
        end
    end
end
tree = treeNodes;

            
        