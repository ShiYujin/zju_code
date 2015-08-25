figure
plot3(cm(1), cm(2), max(node_xyz(3,:)), 'r.', 'MarkerSize', 18);
hold on;
plot3([cm(1),cm(1)],[cm(2),min(node_xyz(2,:))],[max(node_xyz(3,:)),max(node_xyz(3,:))],'r','LineWidth',1);
hold on;
plot3(bcm(1), bcm(2), max(node_xyz(3,:)), 'magenta.', 'MarkerSize', 18);
hold on;
plot3([bcm(1),bcm(1)],[bcm(2),min(node_xyz(2,:))],[max(node_xyz(3,:)),max(node_xyz(3,:))],'magenta','LineWidth',1);
hold on;

x = min(node_xyz(1,:)) : 0.01 : max(node_xyz(1,:));
y = min(node_xyz(2,:)) : 0.01 : (min(node_xyz(2,:)) + h);
z = max(node_xyz(3,:)) * ones(length(y),length(x));
mesh(x,y,z,'FaceColor','blue','EdgeColor','blue','FaceAlpha',0.2, 'EdgeAlpha', 0);
hold on;

handle = patch ( 'Vertices', node_xyz', 'Faces', face_node' );
set ( handle, 'FaceColor', [0.8,0.8,0.8], 'EdgeColor', [0.8,0.8,0.8], ...
    'FaceAlpha',0.5, 'EdgeAlpha', 0, ...
    'EdgeLighting', 'flat ', 'FaceLighting', 'flat '); % phong
light('Position',[30 30 30],'Style','infinite');
hold on;
handle = patch ( 'Vertices', node_xyz_in', 'Faces', face_node' );
set ( handle, 'FaceColor', 'yellow', 'EdgeColor', [1,1,1], ...
    'FaceAlpha',0, 'EdgeAlpha', 1, ...
    'EdgeLighting', 'flat ', 'FaceLighting', 'flat ');
light('Position',[30 30 30],'Style','infinite','color',[0.4,0.4,0.4]);

axis equal; 
xlim;
ylim;
zlim;
grid on;

xlabel ( '--X axis--' )
ylabel ( '--Y axis--' )
zlabel ( '--Z axis--' )
