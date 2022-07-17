function cost =  path_cost(path)
cur = path(:,1); 
cost = 0;
for i = 2:length(path)
    nex = path(:,i);
    cost = cost + norm(nex-cur);
    cur = nex;
end