function traceAncestors(P, E, O, Z)
    tempShowOffsetPolygons(P, E, O);
    hold on;
    ploc=[17 18]; %where the parents are in a particle description vector
    n = size(Z,1);
    for i=1:n
        p = [Z(i,[2 3]); Z(i,[4 5])];
        plot(p(:,2), p(:,1), 'bx-');
        for k=1:2
            if Z(i,ploc(k))>=0
                j = Z(i,ploc(k))+1;
                q = [Z(i,[2 3]); Z(j,[2 3])];
                plot(q(:,2), q(:,1), 'mx-');
            end
        end
    end
    rv = rand(n,2)*0.1;
    z = double(Z(:,[4 5])) + rv;
    text(z(:,2), z(:,1), num2str(int32(Z(:,1))));
    hold off;
   