function [face_in, face_out] = face_calibration(node_xyz, face_node, offset_vector, face_num)
    % use skeleton instead normal!
    face_in = zeros(3, face_num);
    face_out = zeros(3, face_num);
    for i = 1 : face_num
        node = face_node(:,i);
        node1 = node_xyz(:,node(1));
        node2 = node_xyz(:,node(2));
        node3 = node_xyz(:,node(3));
        e12 = node2 - node1;
        e23 = node3 - node2;
        if(dot(offset_vector(:, node(1)), cross(e12,e23)) > 0 )
            face_out(:,i) = reserve(node);
            face_in(:,i) = node;
        else
            face_in(:,i) = reserve(node);
            face_out(:,i) = node;
        end
    end
end

function r = reserve(vec)
    r = zeros(3,1);
    r(1) = vec(1);
    r(2) = vec(3);
    r(3) = vec(2);
end