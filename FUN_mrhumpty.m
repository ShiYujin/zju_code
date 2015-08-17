function r = FUN_mrhumpty(x, H, node_xyz, face_in, offset_vector_in, node_num, face_num, integral)
%     node_xyz_in = cal_node_xyz(node_xyz, x', H, offset_vector_in, node_num);
%     face_in_tem = face_in + node_num;
%     [mass, cm, inertia] = mass_properties([node_xyz, node_xyz_in], [face_out, face_in_tem], face_num * 2);

    node_xyz_in = cal_node_xyz(node_xyz, x', H, offset_vector_in, node_num);
    integral = integral + getIntegral_c(node_xyz_in, face_in, face_num);
    mass = integral(1);
    % mass == 0 -> the input triangle mesh is illegal
    if( mass == 0 )
        fprintf(1, 'Fetal error: mass == 0!\n');
        error ( 'mass_properties - Fatal error!' );
    end
    % center of mass
    cm = integral(2:4) ./ mass;

    r = (cm(3) - 14) ^ 2 + cm(2);
end