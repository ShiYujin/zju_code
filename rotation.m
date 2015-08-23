function node_xyz = rotation(node_in, theta, xyz)
    % rotationM = zeros(3,3);
    switch(xyz)
        case 'x'
            rotationM = [   1,          0,           0; ...
                            0, cos(theta), -sin(theta); ...
                            0, sin(theta),  cos(theta)];
        case 'y'
            rotationM = [ cos(theta),	0,  sin(theta); ...
                                   0,	1,           0; ...
                         -sin(theta),   0,  cos(theta)];
        case 'z'
            rotationM = [cos(theta),	-sin(theta),	0; ...
                         sin(theta),     cos(theta),    0; ...
                                  0,              0,    1];
        otherwise
        fprintf(1, 'Fetal error: xyz illegal!\n');
        error ( 'rotation - Fatal error!' );
    end
    node_xyz = rotationM * node_in;
end