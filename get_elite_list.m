function [cur_cost,points] = get_elite_list(path_js,num,costs)
[out,idx] = sort(costs);
pointsx = [];
pointsy = [];
num
idx(num);
cur_cost = costs(idx(1));
for i = 1:length(num)
    cur = idx(i);
   pointsx = [pointsx,path_js(2*(cur-1)+1,:)];
   pointsy = [pointsy,path_js(2*(cur),:)];
end
points = [pointsx;pointsy]';