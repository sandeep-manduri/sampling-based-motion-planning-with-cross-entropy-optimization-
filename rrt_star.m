function [complete_path] = rrt_star(par, initNode, goalNode, MAX_NODES, num_path_steps, phi1_range, phi2_range,alphas,mus,sigmas)
% Initialize the root node.
%global treeNodes
tree_idx = 1;
treeNodes(tree_idx).parent = 0;%parent ID of root node is 0 
treeNodes(tree_idx).coord = initNode.coord; %TODO
treeNodes(tree_idx).val = 0;

%Initialize the path to the goal to be an empty array
path_js = [];

%List for invalid Nodes for which a valid path cannot exist
invNodes = [];
tol = 0.01;


%RRTfig = figure(10);
%hold on;
obs_discretization_steps = [10];
obs_range = [0.5 0;0.93 0.39];
obs_coords = discretizeObstacle(obs_range,obs_discretization_steps);

r = 0.1;

for num_nodes = 1:MAX_NODES%Loop over the maximum number of nodes.
    
    % Randomly sample joint values in the valid range
    goal_bias_factor = 0.5;
    if(goal_bias_factor~=0)
      randNode = biasSampleRandomNode(phi1_range,phi2_range,goalNode.coord,goal_bias_factor,alphas,mus,sigmas);
      %randNode = biasSampleRandomNode_rrtstar(phi1_range,phi2_range,goalNode.coord,goal_bias_factor);
    else
    randNode = sampleRandomNode(phi1_range,phi2_range);% TODO
    end
    % Find the id of nearest neighbor in the tree to connect to.
    nnId = findNearestNeighbor(treeNodes, randNode); %TODO
    
    
    % Get the C-space coordinates of the nearest neighbor.
    neighbor = treeNodes(nnId).coord;
    
    %Compute the joint space path between nearest neighbor and the random node.
    pathToRandNode = computePath(neighbor,randNode,num_path_steps); % TODO
    
    % Create the potential new node coordinates to be added to the tree.
    newNode = pathToRandNode(:,3)'; % TODO
    
    % Perform collision checking to ensure the potential candidate to be
    % added to the tree and the path to it are collision free. The same
    % collision checking criteria holds for this part of the assignment
    % too. The end effector must maintain a clearance of 0.1 m from the
    % obstacles.
    [eef_coords] = getEndEffectorPositions(par,pathToRandNode(:,1:5)); % TODO
    %Get C-space obstacle 
    [obsList] = findObstacles(eef_coords,obs_coords);%TODO
    % If the potential new node and the path to it are collision tree,
    % update the treeNode list with the new node.
    if(isempty(obsList))%TODO)
        % Save the nearest neighbour as the parent node.
        tree_idx = tree_idx+1;
        new_idx = tree_idx;
        treeNodes(new_idx).parent = nnId;
        treeNodes(new_idx).coord = newNode;
        %disp("length")
        %length(treeNodes)
        near_coord = treeNodes(nnId).coord;
        %nnn = getEndEffectorPositions(par, newNode');
        %ccc = getEndEffectorPositions(par, near_coord');
        
        cur_best = norm(near_coord-newNode) + treeNodes(nnId).val;
        treeNodes(new_idx).val = cur_best;
        [nearNodes_r,treeNodes] = near(treeNodes,new_idx,r,cur_best,par);
        
        treeNodes = rewire(nearNodes_r,new_idx,treeNodes,par);
        
        % Check if the new node added to the tree is within the goal
        % tolerance.
        if (goalReached(goalNode.coord,newNode,tol)==1)
            %sprintf('Goal reached')
            %disp(tree_idx)
            %treeNodes(tree_idx+1).id = tree_idx+1;
            treeNodes(tree_idx+1).parent = tree_idx;
            treeNodes(tree_idx+1).coord = goalNode.coord;
            treeNodes(tree_idx+1).val = treeNodes(tree_idx).val + tol;
            prev = tree_idx;
            path_js = [goalNode.coord];
                      
            while(prev~=0)
                %prev
                path_js = [path_js;treeNodes(prev).coord];
                prev = treeNodes(prev).parent;
                %disp(prev)
                %disp(1)
            end
            % Construct the path to the goal by tracking the parents of the
            % different nodes along the found node path.
            % WRITE YOUR CODE HERE!!
            % TODO: Terminate the loop and return the path
      
            break
        end
    else
        %The potential node is invalid. Add it to the list for invalid Nodes
        invNodes = [invNodes;newNode];%Write your code here
    end
    
    %yourRRTBuddy(RRTfig,initNode,goalNode,treeNodes,invNodes,[],phi1_range,phi2_range);
    
end
for i = 1:length(treeNodes)
   % treeNodes(i).parent
end
%disp(tree_idx);
complete_path = fliplr(path_js');%Write your code here
%yourRRTBuddy(RRTfig,initNode,goalNode,treeNodes,invNodes,path_js',phi1_range,phi2_range);
end