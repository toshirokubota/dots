function tempShowTrebles(P, F, E, T)
    clf;
    tempDrawTriangles2(P, F, 0, [], 'LineWidth', 2, 'Color', [0 0 1]);
    hold on;
    
%     colors=[1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1];
    ri=randperm(size(T,1));
%     ri=[ 285 271];
    for j=1:length(ri)
        i=ri(j);
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
    end
    hold off;
    