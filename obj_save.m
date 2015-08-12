function obj_save(file_name, node_num, face_num, normal_num, node, face_node, nromal, face_normal)
    output = fopen(file_name, 'w');
    if(output < 0)
        fprintf ( 1, '\n');
        fprintf ( 1, 'obj_save - Fatal error!\n' );
        fprintf ( 1, '  Could not open the file "%s".\n', file_name );
        error ( 'obj_save - Fatal error!' );
    end
    
    fprintf(output, '#');
    if( node_num > 0 )
        fprintf(output, ' node: %d', node_num);
    end
    if( face_num > 0 )
        fprintf(output, ' face: %d', face_num);
    end
    if( normal_num > 0 )
        fprintf(output, ' normal: %d', normal_num);
    end
    fprintf(output, '\n');
    
    for i = 1:node_num
        fprintf(output, 'v %f %f %f\n', node(1,i), node(2,i), node(3,i));
    end
    
    for i = 1:normal_num
        fprintf(output, 'vn %f %f %f\n', nromal(1,i), nromal(2,i), nromal(3,i));
    end
    
    for i = 1:face_num
        if(normal_num > 0)
            fprintf(output, 'f %d//%d %d//%d %d//%d\n', ...
                face_node(1,i), face_normal(1,i), face_node(2,i), face_normal(2,i), face_node(3,i), face_normal(3,i));
        else
            fprintf(output, 'f %d %d %d\n', face_node(1,i), face_node(2,i), face_node(3,i));
        end
    end
    
    fclose(output);
end