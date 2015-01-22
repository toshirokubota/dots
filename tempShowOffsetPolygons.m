function tempShowOffsetPolygons(P, E, O)
    showPoints(P, [], [], 'k.', 'MarkerSize', 10);
    tempDrawEdges(P,E(:,1:2), [], [], [], 'Color', [0 0 1], 'LineWidth', 2);
    axis([min(P(:,2))-50 max(P(:,2))+50 min(P(:,1))-50 max(P(:,1))+50]);
    hold on;
    for i=1:length(O)
        p=O{i};
        plot(p([1:end 1],2), p([1:end 1],1), 'g-', 'LineWidth', 1);
    end
    hold off;
