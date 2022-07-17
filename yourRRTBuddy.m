function yourRRTBuddy(RRTfig,initNode,goalNode,treeNodes,invList,path_js,phi1_range,phi2_range)

clf
set(RRTfig,'position',[425  80  459   489],'color','w');
AxesHandle = axes('Parent',RRTfig);
axis equal;
axis([phi1_range phi2_range])
grid on;
box on;
xlabel('\phi_1','fontsize',15);
ylabel('\phi_2','fontsize',15);
title("nodes",length(treeNodes));
C = initNode.coord;
for i = 1:size(treeNodes,2)
    edge(i) = line('Parent',AxesHandle, 'Color','k');
    c = treeNodes(i).coord;
    C(i,:) = c;
    p = treeNodes(i).parent;
    if p ~= 0
        pc = treeNodes(p).coord;
        E(i,:) = [c(1) pc(1) c(2) pc(2)];
    else
        E(i,:) = [c(1) c(1) c(2) c(2)];
    end
    set(edge(i),'XData',E(i,1:2),'YData',E(i,3:4))
end
nodes = line('Parent',AxesHandle, 'MarkerFaceColor','c','Marker','o','MarkerSize',5,'linestyle','none');
invNodes = line('Parent',AxesHandle, 'MarkerFaceColor','r','Marker','o','MarkerSize',5,'linestyle','none');

set(nodes,'XData',C(:,1),'YData',C(:,2));
if(~isempty(invList))
    set(invNodes,'XData',invList(:,1),'YData',invList(:,2));
end

if(~isempty(path_js))
    path = line('Parent',AxesHandle, 'MarkerFaceColor','g','Marker','o','MarkerSize',3,'color','g','linewidth',1.5);
    set(path,'XData',path_js(1,:),'YData',path_js(2,:));
end

start = line('Parent',AxesHandle, 'MarkerFaceColor','k','Marker','^','MarkerSize',8,'linestyle','none');
finish = line('Parent',AxesHandle, 'MarkerFaceColor','b','Marker','o','MarkerSize',8,'linestyle','none');

set(start,'XData',initNode.coord*[1;0],'YData',initNode.coord*[0;1]);
text(initNode.coord*[1;0]+0.05,initNode.coord*[0;1],'S','FontWeight','bold');
set(finish,'XData',goalNode.coord*[1;0],'YData',goalNode.coord*[0;1]);
text(goalNode.coord*[1;0],goalNode.coord*[0;1]+0.05,'G','FontWeight','bold');

drawnow
pause(0.01);