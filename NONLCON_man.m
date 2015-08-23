function [C, Ceq] = NONLCON_man(x, H, node_xyz, face_in, offset_vector_in, node_num, face_num, integral, bcm)
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

    C = cm(2) - bcm(2);
    Ceq(1) = cm(1) - bcm(1);
    Ceq(2) = cm(3) - bcm(3);
end