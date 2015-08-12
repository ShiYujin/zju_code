function integral = getIntegral(node_xyz, face_node, face_num)
    integral = zeros(1,10);% order: 1, x, y, z, x^2, y^2, z^2, xy, yz, zx
    for i = 1 : face_num
        % get vertices of ith triangle
        tri = face_node(:,i);
        node1 = node_xyz(:,tri(1));
        node2 = node_xyz(:,tri(2));
        node3 = node_xyz(:,tri(3));
        % get edges and cross product of edges
        e1 = node2 - node1;
        e2 = node3 - node1;
        d = cross(e1, e2);
        % compute integral terms
        [fx, gx] = subExpressions([node1(1),node2(1),node3(1)]);
        [fy, gy] = subExpressions([node1(2),node2(2),node3(2)]);
        [fz, gz] = subExpressions([node1(3),node2(3),node3(3)]);
        % update integrals
        integral(1) = integral(1) + d(1) * fx(1);

        integral(2) = integral(2) + d(1) * fx(2);
        integral(3) = integral(3) + d(2) * fy(2);
        integral(4) = integral(4) + d(3) * fz(2);
        
        integral(5) = integral(5) + d(1) * fx(3);
        integral(6) = integral(6) + d(2) * fy(3);
        integral(7) = integral(7) + d(3) * fz(3);
        
        integral(8) = integral(8) + d(1) * ...
            (node1(2) * gx(1) + node2(2) * gx(2) + node3(2) * gx(3));
        integral(9) = integral(9) + d(2) * ...
            (node1(3) * gy(1) + node2(3) * gy(2) + node3(3) * gy(3));
        integral(10) = integral(10) + d(3) * ...
            (node1(1) * gz(1) + node2(1) * gz(2) + node3(1) * gz(3));
    end
    integral(1) = integral(1) ./ 6;
    integral(2:4) = integral(2:4) ./ 24;
%     integral(3) = integral(3) / 24;
%     integral(4) = integral(4) / 24;
    integral(5:7) = integral(5:7) ./ 60;
%     integral(6) = integral(6) / 60;
%     integral(7) = integral(7) / 60;
    integral(8:10) = integral(8:10) ./ 120;
%     integral(9) = integral(9) / 120;
%     integral(10) = integral(10) / 120;

end

function [f, g] = subExpressions(w)
    f = zeros(1, 3);
    % g = zeros(1, 3);
    f(1) = sum(w);
    f(2) = f(1) * w(1) + ...
        w(2) * w(2) + w(3) * w(3) + w(2) * w(3);
    f(3) = w(1) * f(2) + ...
        power(w(2),3) + w(2) * power(w(3),2) + ...
        power(w(3),3) + w(3) * power(w(2),2);
    g = f(2) + w .* (w + f(1));
%     g(1) = f(2) + w(1) * (f(1) + w(1));
%     g(2) = f(2) + w(2) * (f(1) + w(2));
%     g(3) = f(2) + w(3) * (f(1) + w(3));
end
