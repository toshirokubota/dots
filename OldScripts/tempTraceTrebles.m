function tempShowTrebles(P, F, E, T)
    clf;
    tempDrawTriangles2(P, F, 0, [], 'LineWidth', 2, 'Color', [0 0 1]);
    hold on;
    
    sel = 1:size(T,1);
    sel = randperm(size(T,1));
%     sel(find(sel==43))=[];
%     sel =  [43 sel];
    j=1;
    while length(sel)>0
        i=sel(j);
        sel(j)=[];
        e = T(i,1:3);
        if all(e)
            t = E(e,1:2);
            title(sprintf('%f ', T(i,:)));
            plot(P(t(1,:),2), P(t(1,:),1), 'LineWidth', 2, 'Color', [0 1 0]);
            plot(P(t(2,:),2), P(t(2,:),1), 'LineWidth', 2, 'Color', [1 0 0]);
            plot(P(t(3,:),2), P(t(3,:),1), 'LineWidth', 2, 'Color', [0 1 0]);
            pause;
            plot(P(t(1,:),2), P(t(1,:),1), 'LineWidth', 2, 'Color', [0 0 1]);
            plot(P(t(2,:),2), P(t(2,:),1), 'LineWidth', 2, 'Color', [0 0 1]);
            plot(P(t(3,:),2), P(t(3,:),1), 'LineWidth', 2, 'Color', [0 0 1]);
        end
        j = find(sel==e(1));
        if isempty(j)
            j = find(sel==e(3));
            if isempty(j) & ~isempty(sel)
                j = sel(1);
            end
        end
    end
    hold off;
    