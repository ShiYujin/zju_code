figure
plot3(cm(1), cm(2), cm(3), 'r.', 'MarkerSize', 18);
hold on;
plot3([cm(1),cm(1)],[cm(2),0],[cm(3),cm(3)],'r','LineWidth',2);
hold on;
plot3(cm_in(1), cm_in(2), cm_in(3), 'magenta.', 'MarkerSize', 18);
hold on;
plot3([cm_in(1),cm_in(1)],[cm_in(2),0],[cm_in(3),cm_in(3)],'magenta','LineWidth',2);
hold on;
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
