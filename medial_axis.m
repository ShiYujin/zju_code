function [map, skel_node, skel_num] = medial_axis(node_num, node_xyz)
    skel_node_tem = zeros(3,node_num);
    skel_num = 2;
    skel_node_tem(:,1) = [0;-30;30];
    skel_node_tem(:,2) = [0;28;-28];
    map = zeros(2,node_num);
    for i = 1 : node_num
        y = (node_xyz(2,i) - node_xyz(3,i)) / 2;
        z = -y;
        if(z > 30)
            map(2,i) = 1;
        elseif(z < -28)
            map(2,i) = 2;
        else
            skel_num = skel_num + 1;
            skel_node_tem(:,skel_num) = [0;y;z];
            map(2,i) = skel_num;
        end
    end
    skel_node = skel_node_tem(:,1:skel_num);
end