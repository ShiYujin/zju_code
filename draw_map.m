% clear;
% clc;
%% read file
% [ node_num, face_num, normal_num, ...
%     node_xyz, face_order, face_node, normal_vector, vertex_normal] ...
%     = obj_display('E:\Project\zju_code\triangleMesh\3spheres_stand.obj');
% [skel_node, edge, skel_face, map, skel_num, edge_num, skel_face_num, map_num] = map_reader('E:\Project\zju_code\triangleMesh\3spheres_stand_copy1.obj');

%% draw skeleton
% for i = 1 : skel_num
%     plot3(skel_node(1,i),skel_node(2,i),skel_node(3,i),'go','LineWidth', 2);
%     hold on;
% end
% 
% for i = 1 : edge_num2
%     e = edge2(:,i);
%     v1 = skel_node2(:,e(1));
%     v2 = skel_node2(:,e(2));
%     xyz = [v1,v2];
%     plot3(xyz(1,:),xyz(2,:),xyz(3,:),'r','LineWidth',2);
%     hold on;
% end

%% draw map
figure;
for i = 1 : map_num
    v = map(2,i);
    v1 = node_xyz(:,i);
    v2 = skel_node(:,v);
    xyz = [v1,v2];
    plot3(xyz(1,:),xyz(2,:),xyz(3,:),'r','LineWidth',1);
    hold on;
end
%%
handle = patch ( 'Vertices', node_xyz', 'Faces', face_node' );
set ( handle, 'EdgeColor', 'cyan' ,'FaceAlpha', 0, 'EdgeAlpha', 0.1);

handle2 = patch ( 'Vertices', skel_node', 'Faces', skel_face' );
set ( handle2, 'EdgeColor', 'blue' ,'FaceAlpha', 0, 'EdgeAlpha', 0.1);

axis equal; 
xlim;
ylim;
zlim;
grid on;

xlabel ( '--X axis--' )
ylabel ( '--Y axis--' )
zlabel ( '--Z axis--' )
%%
figure;

handle = patch ( 'Vertices', node_xyz', 'Faces', face_node' );
set ( handle, 'FaceColor', [0.5, 0.6, 0.8], 'EdgeColor', 'Black' );

axis equal; 
xlim;
ylim;
zlim;
grid on;

xlabel ( '--X axis--' )
ylabel ( '--Y axis--' )
zlabel ( '--Z axis--' )
%%
figure;

handle = patch ( 'Vertices', skel_node', 'Faces', skel_face' );
set ( handle, 'FaceColor', [0.5, 0.6, 0.8], 'EdgeColor', 'Black' );

axis equal; 
xlim;
ylim;
zlim;
grid on;

xlabel ( '--X axis--' )
ylabel ( '--Y axis--' )
zlabel ( '--Z axis--' )
%%
% a unit cube
% face_num = 12;
% node_num = 8;
% node_xyz = [0,1,0,0,0,1,1,1;0,0,1,0,1,0,1,1;0,0,0,1,1,1,0,1];
% face_node = [1,1,4,4,2,2,1,1,1,1,8,8;7,3,6,8,8,7,4,5,2,6,7,3;2,7,8,5,6,8,5,3,6,4,3,5];
% face_node_neg = [1,1,4,4,2,2,1,1,1,1,8,8;2,7,8,5,6,8,5,3,6,4,3,5;7,3,6,8,8,7,4,5,2,6,7,3];
% normal_vector = [0,0,0,0,1,1,-1,-1,0,0,0,0;0,0,0,0,0,0,0,0,-1,-1,1,1;-1,-1,1,1,0,0,00,0,0,0,0,0];

