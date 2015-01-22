function  [cost C] = shapeMatchDP(P, Q)
    if size(P,1) > size(Q,1)
        temp = P;
        P = Q;
        Q = temp;
    end
    
    D = pdist2(P, Q);
    C = zeros(size(D));
    C(1,:) = cumsum(D(1,:), 2);
    C(:,1) = cumsum(D(:,1), 1);
    
    for i=2:size(C,1)
        for j=2:size(C,2)
            v1 = C(i-1,j-1) + D(i,j);
            v2  = C(i,j-1) + D(i,j);
            v3 = C(i-1,j) + D(i,j);
            C(i,j) = min([v1, v2, v3]);
        end
    end
    
    cost = C(size(C,1),size(C,2)) / size(Q,1);
    