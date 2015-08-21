function r = FUN_man(x, H, node_xyz, face_in, offset_vector_in, node_num, face_num, rh0_mass0)
    node_xyz_in = cal_node_xyz(node_xyz, x', H, offset_vector_in, node_num);
    integral = getIntegral_c(node_xyz_in, face_in, face_num);
    mass = integral(1);
    % mass == 0 -> the input triangle mesh is illegal
    if( mass == 0 )
        fprintf(1, 'Fetal error: mass == 0!\n');
        error ( 'mass_properties - Fatal error!' );
    end

    r = (rh0_mass0 + abs(mass)) ^ 2;
end