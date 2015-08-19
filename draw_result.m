figure
plot3([cm(1),cm(1)],[cm(2),-50],[cm(3),cm(3)],'r','LineWidth',3);
handle = patch ( 'Vertices', node_xyz', 'Faces', face_node' );
set ( handle, 'FaceColor', 'Yellow', 'EdgeColor', 'Blue' ,'FaceAlpha',0.1);

