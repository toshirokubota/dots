function showEdges(edges, contours)
%visualize graph edges
%edges are [x1 y1 x2 y2 weight contour1 point1 contour2 point2]
    for i=1:size(edges,1)
        plot(edges(i,2), edges(i,1), 'r.', 'MarkerSize', 5);
        hold on;
        if edges(i,6)==edges(i,8) %same contour
%         plot(edges(i,[2 4]), edges(i,[1 3]), 'r
            c=contours{edges(i,6)};
            plot(c(:,2), c(:,1), 'r-');
        else
            warning off;
            arrow(edges(i,2:-1:1), edges(i,4:-1:3), 5, 30);
            warning on;
%             quiver(edges(i,2), edges(i,1), edges(i,4)-edges(i,2), edges(i,3)-edges(i,1));
        end
    end
    for i=1:length(contours)
        c = double(contours{i});
        text(c(1,2), c(1,1), sprintf('%d', i-1));
    end
    axis equal;
    set(gca, 'YDir', 'reverse');
    hold off;
    