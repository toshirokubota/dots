function tempShowRegions(P, regions)

    for i=1:length(regions)
        clf;
        showPoints(P, [], [], 'b.', 'MarkerSize', 20);
        hold on;
        showPoints(P(regions{i},:), [], [], 'r.', 'MarkerSize', 20);
        title(num2str(i));
        pause;
    end
