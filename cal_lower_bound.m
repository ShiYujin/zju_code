function bound_min = cal_lower_bound(offset, node_num, normal, offset_vector, bound_max)
    bound_min = zeros(1,node_num);
    for i = 1 : node_num 
        bound_min(i) = - offset / dot(normal(:,i), offset_vector(:,i)) * norm(normal(:,i)) * norm(offset_vector(:,i));
        if(bound_min(i) > bound_max(i))
            bound_min(i) = bound_max(i) * 0.9;
        end
        if(bound_min(i) < 0)
            bound_min(i) = 0;
        end
    end
end