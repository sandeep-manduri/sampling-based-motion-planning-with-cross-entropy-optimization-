function rewired_tree = rewire(nears,new,treeNodes,par)
 %global treeNodes
 %disp("in rewiring")
 %length(nears)
 new_cood = treeNodes(new).coord;
 nnn = new_cood;
  for i = 1:length(nears)
        cur = treeNodes(i).coord;
        
        %nnn = getEndEffectorPositions(par, new_cood');
        %ccc = getEndEffectorPositions(par, cur');
           ccc = cur;
           
        dist = norm(ccc-nnn);
        cur_val = dist + treeNodes(new).val;
        
        if(cur_val<treeNodes(i).val)
            %disp("best found")
            treeNodes(i).parent = new;
            treeNodes(i).val = cur_val;
        end
  end
  rewired_tree = treeNodes;
        
