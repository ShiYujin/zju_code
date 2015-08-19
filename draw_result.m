figure
plot3(cm(1), cm(2), cm(3), 'r.', 'MarkerSize', 18);
hold on;
plot3([cm(1),cm(1)],[cm(2),-47],[cm(3),cm(3)],'r','LineWidth',2);
handle = patch ( 'Vertices', node_xyz', 'Faces', face_node' );
set ( handle, 'FaceColor', 'Yellow', 'EdgeColor', 'Blue' ,'FaceAlpha',0.1);

axis equal; 
xlim;
ylim;
zlim;
grid on;

xlabel ( '--X axis--' )
ylabel ( '--Y axis--' )
zlabel ( '--Z axis--' )
