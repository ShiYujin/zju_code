function lap=GetLapalaceOp(node_num, face_num, node_xyz, face_node)
% return n*n Lapalace-Beltrami operator
%
    lap = zeros(node_num, node_num);
%     node = zeros(3, 1);
%     xy = zeros(3, 1);
%     yz = zeros(3, 1);
%     zx = zeros(3, 1);
    for i = 1:1:face_num
        node = face_node(:, i);
        xy = node_xyz(:,node(1)) - node_xyz(:,node(2));
        yz = node_xyz(:,node(2)) - node_xyz(:,node(3));
        zx = node_xyz(:,node(3)) - node_xyz(:,node(1));
        
        cs = dot(xy,yz)/(norm(xy)*norm(yz));
        lap(node(1), node(3)) = lap(node(1), node(3)) + ...
            0.5 * cs / sqrt ( 1 - cs * cs );
        %lap(node(3), node(1)) = lap(node(1), node(3));
        
        cs = dot(yz,zx)/(norm(yz)*norm(zx));
        lap(node(1), node(2)) = lap(node(1), node(2)) + ...
            0.5 * cs / sqrt ( 1 - cs * cs );
        %lap(node(2), node(1)) = lap(node(1), node(2));
        
        cs = dot(zx,xy)/(norm(zx)*norm(xy));
        lap(node(2), node(3)) = lap(node(2), node(3)) + ...
            0.5 * cs / sqrt ( 1 - cs * cs );
        %lap(node(3), node(2)) = lap(node(2), node(3));
    end
    lap = lap + lap';
    s = sum(lap,1);
    for i = 1:1:node_num
        lap(i,i) = - s(i);
    end
    return;
end