function r = FUN_ss(x, H, node_xyz, face_in, face_out, offset_vector_in, node_num, face_num)
    node_xyz_in = cal_node_xyz(node_xyz, x', H, offset_vector_in, node_num);
    face_in_tem = face_in + node_num;
    [mass, cm, inertia] = mass_properties([node_xyz, node_xyz_in], [face_out, face_in_tem], face_num * 2);
    r = cm(1) ^ 2 + (cm(3) - 37) ^ 2;% + cm(2);
end