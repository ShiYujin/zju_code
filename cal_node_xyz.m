function node_xyz_output = cal_node_xyz(node_xyz_input, alpha, H, vector, node_num)
    node_xyz_output = zeros(3, node_num);
    node_xyz_output(1,:) = node_xyz_input(1,:) + alpha * H' .* vector(1,:);
    node_xyz_output(2,:) = node_xyz_input(2,:) + alpha * H' .* vector(2,:);
    node_xyz_output(3,:) = node_xyz_input(3,:) + alpha * H' .* vector(3,:);
end