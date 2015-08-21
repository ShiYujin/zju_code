function [ bnode_num, bface_num, bnode_xyz, bface_node, bnormal_vector] = ...
    get_button(node_num, face_num, node_xyz, face_node, normal_vector, h)

    surface = h + min(node_xyz(2,:));
    if(surface > max(node_xyz(2,:)) || surface < min(node_xyz(2,:)))
        fprintf(1, 'Fetal error: surface overflow!\n');
        error ( 'get_button - Fatal error!' );
    end
%     adjacency = zeros(node_num, node_num);
%     for i = 1 : face_num
%         face = face_node(:,i);
%         adjacency(face(1), face(2)) = 1;
%         adjacency(face(2), face(3)) = 1;
%         adjacency(face(3), face(1)) = 1;
%         adjacency(face(2), face(1)) = 1;
%         adjacency(face(3), face(2)) = 1;
%         adjacency(face(1), face(3)) = 1;
%     end

%     bnode_num = 0;
%     bface_num = 0;
    node_bool = (node_xyz(2,:) < surface);
    face_bool = zeros(1,face_num);
    border = [];
    center = zeros(3,1);
    for i = 1:face_num
        s = node_bool(face_node(1,i)) + node_bool(face_node(2,i)) + node_bool(face_node(3,i));
        if ( s == 3 )
            face_bool(i) = 1;
        elseif ( s == 0 )
            face_bool(i) = 0;
        elseif ( s == 1 )
            face_bool(i) = 0;
        else % s == 2
            face_bool(i) = 1;
            i0 = 0;
            i1 = 0;
            i2 = 0;
            if(node_bool(face_node(1,i)) == 0)
                i0 = face_node(1,i);
                i1 = face_node(2,i);
                i2 = face_node(3,i);
            elseif (node_bool(face_node(2,i)) == 0)
                i0 = face_node(2,i);
                i1 = face_node(3,i);
                i2 = face_node(1,i);
            else
                i0 = face_node(3,i);
                i1 = face_node(1,i);
                i2 = face_node(2,i);
            end
            border = [border,[i1;i0],[i0;i2]];
            center = center + node_xyz(:,i0) + node_xyz(:,i1) + node_xyz(:,i2);
            node_bool(i0) = 1;
        end
    end
    bnode_num = sum(node_bool) + 1;
    bface_num = sum(face_bool) + size(border,2);
    center = center ./ (size(border,2) / 2 * 3);
    bnode_xyz = zeros(3, bnode_num);
    bface_node = zeros(3, bface_num);
    bnormal_vector = zeros(3, bnode_num);
    j = 1;
    for i = 1 : node_num
        if(node_bool(i) == 1)
            bnode_xyz(:,j) = node_xyz(:,i);
            bnormal_vector(:,j) = normal_vector(:,i);
            j = j + 1;
        end
    end
    bnode_xyz(:, bnode_num) = center;
    bnormal_vector(:, bnode_num) = [0;1;0];
    j = 1;
    for i = 1 : face_num
        if(face_bool(i) == 1)
            bface_node(:,j) = face_node(:,i);
            j = j + 1;
        end
    end
    for i = 1 : node_num
        t = sum(node_bool(1:i));
        bface_node(1, find(bface_node(1,:) == i)) = t;
        bface_node(2, find(bface_node(2,:) == i)) = t;
        bface_node(3, find(bface_node(3,:) == i)) = t;
        border(1, find(border(1,:) == i)) = t;
        border(2, find(border(2,:) == i)) = t;
    end
    bface_node(:, sum(face_bool) + 1:end) = [border;bnode_num * ones(1,size(border,2))];
    
end