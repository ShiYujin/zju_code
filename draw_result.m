figure
plot3(cm(1), cm(2), max(node_xyz(3,:)), 'r.', 'MarkerSize', 18);
hold on;
plot3([cm(1),cm(1)],[cm(2),min(node_xyz(2,:))],[max(node_xyz(3,:)),max(node_xyz(3,:))],'r','LineWidth',1);
hold on;
% plot3(bcm(1), bcm(2), max(node_xyz(3,:)), 'magenta.', 'MarkerSize', 18);
% hold on;
% plot3([bcm(1),bcm(1)],[bcm(2),min(node_xyz(2,:))],[max(node_xyz(3,:)),max(node_xyz(3,:))],'magenta','LineWidth',1);
% hold on;
handle = patch ( 'Vertices', node_xyz', 'Faces', face_node' );
set ( handle, 'FaceColor', 'cyan', 'EdgeColor', 'cyan' ,'FaceAlpha',0.1);
hold on;
handle = patch ( 'Vertices', node_xyz_in', 'Faces', face_node' );
set ( handle, 'FaceColor', 'Yellow', 'EdgeColor', 'blue' ,'FaceAlpha',0.1);

axis equal; 
xlim;
ylim;
zlim;
grid on;

xlabel ( '--X axis--' )
ylabel ( '--Y axis--' )
zlabel ( '--Z axis--' )
