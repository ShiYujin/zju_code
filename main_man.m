% % clear;
% % clc;
% 
% fprintf(1, 'Specific Volume and Buoyancy of man\n\n');
% 
% %% read file
% tic;
% % node_num,     int,    1*1,        the number of vertex
% % face_num,     int,    1*1,        the number of face
% % normal_num,	int,    1*1,        the number of normal vector
% % node_xyz,     double, 3*node_num,     the coordinate of all node
% % face_order,	int,    1*face_num,     the number of vertex each face include
% % face_node,	int,        order_max*face_num,     the index of node each face include
% % normal_vector,	double, 3*normal_num,           normal vector
% % vertex_normal,	int,    order_max*face_num,     the index of normal vector of vertex of each face
% [ node_num, face_num, normal_num, ...
%     node_xyz, face_order, face_node, normal_vector, vertex_normal] ...
%     = obj_display('E:\Project\zju_code\triangleMesh\man.obj');
% fprintf(1, '\nRead file finished\n');
% toc;
% fprintf(1, '----------------------------\n\n');
% pause off;
% pause;
% %% for futher process, it mush be triangle mesh
% if ( max(face_order) ~= 3 || min(face_order) ~= 3)
%     fprintf(1, 'Error:\n');
%     fprintf(1, '  This is not a pure triangle mesh!\n');
% else
%     %% get lapalace operator
%     tic;
% % lap, double, node_num*node_num, lapalace operator
%     lap = GetLapalaceOp(node_num, face_num, node_xyz, face_node);
%     fprintf(1, '\nCalculate lapalace operator finished\n');
%     toc;
%     fprintf(1, '----------------------------\n\n');
%     %Eigendecomposition
%     tic;
% % H, doubl,  node_num*node_num, eigenvector of lapalace operator
% % D, dobule, node_num*node_num, diagonal matrix, with its diagonal eigenvalue of lapalace operator
% % D mush be non-negative
%     [V,D] = eig(lap);
%     fprintf(1, '\nCalculate eigenvector finished\n');
%     toc;
%     fprintf(1, '----------------------------\n\n');
%     pause;
%     %% get skeleton 
%     tic;
% % skel_num,	 int,   1*1,        the number of vertex in skeleton
% % edge_num,  int,   1*1,        the number of edge in skeleton
% % map_num,   int,   1*1,        the number of map == node_num
% % skel_node, double,3*skel_num, the coordinate of skeleton vertex
% % edge,      int,   2*edge_num, the index of vertex that each edge include
% % map,       int,   2*map_num,  map surface vertex -> skeleton vertex
%     [skel_node, edge, skel_face, map, skel_num, edge_num, skel_face_num, map_num] = ...
%         map_reader('E:\Project\zju_code\triangleMesh\man_copy5.obj');
%     fprintf(1, '\nnCalculate skeleton finished\n');
%     toc;
%     fprintf(1, '----------------------------\n\n');
%     pause;
%     %% get offset vector and bounds
%     tic;
% % offset_vector, double, 3*node_num, offset vector of each vertex
% % offset_bound,  double, 1*node_num, maximum offset of inner surface
%     [offset_vector, offset_bound] = cal_offset(node_xyz, skel_node, map, node_num);
%     fprintf(1, '\nCalculate offset vector and bounds finished\n');
%     toc;
%     fprintf(1, '----------------------------\n\n');
%     pause
%     %% get mass properties
%     tic;
%     [mass0, cm0, inertia0] = mass_properties(node_xyz, face_node, face_num);
%     fprintf(1, '\nnCalculate mass properties finished\n');
%     toc;
%     fprintf(1, '----------------------------\n\n');
%     pause
    %% prepare for Optimization
    tic;
    offset_vector_in = offset_vector;
    offset_vector_out = - offset_vector;
    offset_in_normal = 0.0001;   % should be changed according to the size of object!
    bound_in_max = offset_bound;
    bound_in_min = cal_lower_bound(offset_in_normal, node_num, normal_vector, offset_vector_in, bound_in_max);
    bound_out_min = zeros(1,node_num);  % default to be 0, can be changed according to the size of object!
    bound_out_max = zeros(1,node_num);  % default to be 0, can be changed according to the size of object!
    
    % weight of bound_out, default to be 0
    wp = 0;
    
    % the number of H used, default to be node_num
    k = 80;
    if(k <= node_num)
        H = V(:,1:k);
    else
        H = V;
    end
    rho = 1/1.2; % rho = rho(water) / rho(object);
    h = 0.3;
    
    % variable to be optimizated, 
    % bound_min < H * alpha < bound_max
    alpha_in = zeros(1,k);
    alpha_out = zeros(1,k);
    
    % face calibration
%     [face_in, face_out] = face_calibration(node_xyz, face_node, offset_vector, face_num);
    face_out = face_node;
    face_in = face_node;
    face_in(2,:) = face_node(3,:);
    face_in(3,:) = face_node(2,:);

    % get initial value
%    [alpha_in, alpha_out] = node_initialize(H, alpha_in, alpha_out, bound_in_min, bound_in_max, bound_out_min, bound_out_max);
    
    node_xyz_in = cal_node_xyz(node_xyz, alpha_in, H, offset_vector_in, node_num);
    node_xyz_out = cal_node_xyz(node_xyz, alpha_out, H, offset_vector_out, node_num);
    
    fprintf(1, '\nOptimization preparation finished!\n');
    toc;
    fprintf(1, '----------------------------\n\n');
    pause
    %% Optimization
    % static stability
    % initial value
    % x = fmincon(@(x) 0, alpha_in', [H; -H], [bound_in_max'; -bound_in_min'],[],[],[],[],@myfun,options);
    x_init = fmincon(@(x) 0, alpha_in', [H; -H], [bound_in_max'; -bound_in_min']);
    alpha_in = x_init';
    node_xyz_in = cal_node_xyz(node_xyz, alpha_in, H, offset_vector_in, node_num);
    
    % obj_save('E:\Project\zju_code\triangleMesh\man_autosave_inivalue.obj',node_num,face_num,0,node_xyz_in,face_node,[],[]);

    % suppose: do not change the outer surface
    
    options = optimoptions('fmincon'...
        , 'Algorithm','active-set'...% choose a algorithm:'interior-point','trust-region-reflective','sqp','active-set'
        , 'MaxIter', 3000 ...
        , 'MaxFunEvals', 9000 ...
        , 'Display', 'iter-detailed' ...% 'off','iter','iter-detailed','notify','notify-detailed','final','final-detailed'
        , 'FinDiffType', 'central' ...% 'forward','central'
        , 'FunValCheck', 'on' ...% 'off','on'
        , 'TolCon', 1e-10 ...
        , 'TolX', 1e-10 ...% default:1e-10;
        );

    integral = getIntegral_c(node_xyz, face_out, face_num);
    [bnode_num, bface_num, bnode_xyz, bface_node, bnormal_vector] = ...
        get_button(node_num, face_num, node_xyz, face_node, normal_vector, h);
    [bmass, bcm, binertia] = mass_properties(bnode_xyz, bface_node, bface_num);
    rh0_bmass = (rho - 1) * bmass
    
    tic;
    x = fmincon(@(x) FUN_man(x, H, node_xyz, face_in, offset_vector_in, node_num, face_num, rh0_bmass, mass0), ...
        alpha_in', [H; -H], [bound_in_max'; -bound_in_min'], [], [], [], [], ...
        @(x) NONLCON_man(x, H, node_xyz, face_in, offset_vector_in, node_num, face_num, integral, bcm), ...
        options);
    
    fprintf(1, '\nOptimization finished!\n');
    toc;
    fprintf(1, '----------------------------\n\n');
    pause
    
    alpha_in = x';
    
    node_xyz_in = cal_node_xyz(node_xyz, alpha_in, H, offset_vector_in, node_num);

    % obj_save('E:\Project\zju_code\triangleMesh\man_autosave_result.obj',node_num,face_num,0,node_xyz_in,face_node,[],[]);
    
    face_in_tem = face_in + node_num;
    [mass, cm, ~] = mass_properties([node_xyz, node_xyz_in], [face_out, face_in_tem], face_num * 2);
    mass
    cm
    [mass_in, cm_in, ~] = mass_properties(node_xyz_in, face_in, face_num);
    mass_in
    cm_in
% end

