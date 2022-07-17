function body_animate(t,x,par,xy_eef, enable_obstacle)

%% Settings
colors = [1 0 0];

%% Create link shape
shape1 = linkshape(par.a1);
shape2 = linkshape(par.a2);

%% Objects
clf
animationfig = figure(1);
set(animationfig,'color','w','paperpositionmode','auto','position',[461   145   701   414]);
AxesHandle = axes('Parent',animationfig,  'Position',[0 0 1 1]);

if(enable_obstacle)
    bin1 = line('Parent',AxesHandle,'Color',[0 0 0],'LineWidth',2);
    bin2 = line('Parent',AxesHandle,'Color',[0 0 0],'LineWidth',2);
    ball = line('Parent',AxesHandle, 'MarkerFaceColor',[1 0.5 0],'Marker','o','MarkerSize',32);
end

link1 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:),'facealpha',0.7);
link2 = patch('Parent',AxesHandle, 'FaceColor',colors(1,:),'facealpha',0.7);
path = line('Parent',AxesHandle,'linestyle','--','Color',[0 0.2 0]);

table = line('Parent',AxesHandle, 'Color',[0 0 0], 'LineWidth',2);

if(~isempty(xy_eef))
%     eef = line('Parent',AxesHandle,'Color',[0 0 1],'LineWidth',1,'MarkerFaceColor',[0 1 0],'Marker','o','MarkerSize',16);
    eef = line('Parent',AxesHandle,'MarkerFaceColor',[0 1 0],'Marker','o','MarkerSize',5,'linestyle','none');
end

box on;
axis off;
axis([-1 1 -1 par.a1+par.a2+0.5])
%% Animation

p1=0;
p2=0;
path_xy = [];

% table
table_pos = [-1.5, 1.5; -0.051 -0.051];
%for obstacles
bin1_pos   = [0.5 0.5; -0.051 0.39];
bin2_pos   = [0.93 0.93; -0.051 0.39];
ball_pos   = [0.7173; 0.1967];

set(table,'Xdata',table_pos(1,:),'Ydata',table_pos(2,:));
if(enable_obstacle)
   set(bin1,'Xdata',bin1_pos(1,:),'Ydata',bin1_pos(2,:));
   set(bin2,'Xdata',bin2_pos(1,:),'Ydata',bin2_pos(2,:));
   set(ball,'Xdata',ball_pos(1,:),'Ydata',ball_pos(2,:));
end
if(~isempty(xy_eef))
   set(eef,'Xdata',xy_eef(:,1)','Ydata',xy_eef(:,2)');
end
    
n=0;
while n<length(t)
n=n+1;    
    
    % state vector
    p1 = x(n,1);
    p2 = x(n,2);
    
    % arm positions
    pos1 = move(R(p1)*shape1,[0;0]);
    pos2 = move(R(p2)*shape2,coor(p1, par.a1)-coor(p2, par.a2));
    path_xy = [path_xy;(coor(p1, par.a1)-coor(p2, par.a2))];

    set(link1,'Xdata',pos1(1,:),'Ydata',pos1(2,:));
    set(link2,'Xdata',pos2(1,:),'Ydata',pos2(2,:));
    set(path,'Xdata',path_xy(1:n,1),'Ydata',path_xy(1:n,2));
        
    drawnow
    axis equal
    pause(0.05);
    
end


function d = coor(p, a) %calculates local coordinates using angles
d = [-a*sin(p),a*cos(p)];


function shape = linkshape(l) %creates an arm/link with the ends being semi-circles
link_width = 0.1;
n   = linspace(pi/2,-pi/2,20);
top_arc    = (link_width/2)*[sin(n);cos(n)];
bottom_arc = (link_width/2)*[-sin(n);-cos(n)];
if l<0
    bottom_arc(2,:) = bottom_arc(2,:)+l;
else
    top_arc(2,:) = top_arc(2,:)+l;
end
shape = [top_arc, bottom_arc];


function rot = R(phi)
rot = [cos(phi)  -sin(phi);
       sin(phi)   cos(phi)];
   
function c = move(a, b)
c(1,:) = a(1,:) + b(1);
c(2,:) = a(2,:) + b(2);

        
