function tempDrawCarvedFaceBranch2(P, F, T)
    P = double(P);
    holdstate = ishold();
    if holdstate==0
        clf;
    end
    hold on;
    for i=1:size(T,1)
        if sum(T(i,3:5))<=1 %at most one child
            color = [1 0 0];
        else
            color = [0 0 1];
        end
        k = T(i,1);
        t = F(k,1:3);
        Q = P([t(:)' t(1)], [1 2]);
        plot(Q(:,2), Q(:,1), 'Color', color);
    end
    axis image;
    set(gca, 'YDir', 'reverse');    
    if holdstate==0
        hold off;
    end    
    