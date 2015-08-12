function [offset_vector, offset_bound] = cal_offset(node_xyz, skel_xyz, map, node_num)
    offset_vector = zeros(3, node_num);
    offset_bound = zeros(1, node_num);
    for i = 1 : node_num
        v1 = node_xyz(:,i);
        v2 = skel_xyz(:,map(2,i));
        deltv = v2 - v1;
        offset_vector(:,i) = deltv./norm(deltv);
        offset_bound(i) = norm(deltv);
    end
end