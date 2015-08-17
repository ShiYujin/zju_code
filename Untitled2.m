s = 0;
for i = 1:1000
    e = magic(3);
    
    d1 = cross(e(1,:), e(2,:));
    d2 = mycross(e(1,:), e(2,:));
    s = s + sum(d1 ~= d2);
end