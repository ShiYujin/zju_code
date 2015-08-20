function r = FUN_rs(x, H, node_xyz, face_in, offset_vector_in, node_num, face_num, integral)
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
    % inertia relative to world origin          % inertia relative to center of mass
    inertia(1,1) = integral(6) + integral(7)	- mass * (cm(2) * cm(2) + cm(3) * cm(3));
    inertia(2,2) = integral(5) + integral(7)    - mass * (cm(3) * cm(3) + cm(1) * cm(1));
    inertia(3,3) = integral(5) + integral(6)    - mass * (cm(1) * cm(1) + cm(2) * cm(2));
%     inertia(1,2) = - integral(8)                + mass * cm(1) * cm(2);
%     inertia(2,3) = - integral(9)                + mass * cm(2) * cm(3);
    inertia(1,3) = - integral(10)               + mass * cm(1) * cm(3);
    %
%     inertia(2,1) = inertia(1,2);
%     inertia(3,2) = inertia(2,3);
%     inertia(3,1) = inertia(1,3);
    
    I1 = 0.5 * (inertia(1,1) + inertia(3,3));
    I2 = 0.5 * sqrt(inertia(1,1) ^ 2 + 4 * inertia(1,3) ^ 2 - 2 * inertia(1,1) * inertia(3,3) + inertia(3,3) ^ 2);
    Ia = I1 - I2;
    Ib = I1 + I2;
    r =  (Ia / inertia(2,2)) ^ 2 + (Ib / inertia(2,2)) ^ 2;% mass * cm(2) +
end