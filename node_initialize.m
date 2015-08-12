function [alpha_in, alpha_out] = ...
        node_initialize(H, alpha_in, alpha_out, bound_in_min, bound_in_max, bound_out_min, bound_out_max)
    if(bound_out_min == bound_out_max)
        fprintf(1, 'Warning: bound_out_max == bound_out_min!\n');
    else
        x = fmincon(@(x) nodeinit_f(x, H, bound_out_max), alpha_out, H, bound_out_max');
        alpha_out = x;
    end
    
    if(bound_in_min == bound_in_max)
        fprintf(1, 'Warning: bound_in_max == bound_in_min!\n');
    else
        x = fmincon(@(x) nodeinit_f(x, H, bound_in_max), alpha_in, H, bound_in_max');
        alpha_in = x;
    end

end

function d = nodeinit_f(alpha, H, bound)
    d = norm(alpha * H' - bound);
end
% 
% function [G, Ceq] = nodeinit_g(alpha, H, bound)
%     Ceq = 0;
%     % H * alpha <= bound_in_min
%     G = alpha * H' - bound;
% end
