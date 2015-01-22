function tempClosedPolygonReuslts(P, U)

    clf;
    showPoints(P, [], [], '.k', 'MarkerSize', 14);
    hold on;
    cm = colormap('colorcube');
    for i=1:length(U)
        [P2 G] = ClosedPolygons(U{i});
        h=[];
        scores=[0];
        for j=1:length(G)
            p=G{j};
            k = mod(j-1, size(cm,1)) + 1;
            h(j) = plot(p([1:end 1],2), p([1:end 1], 1), '-', 'Color', cm(k,:), 'LineWidth', 2);
    %         patch(p(:,2), p(:, 1), cm(k,:));
        end
        title(sprintf('%d %d', i, size(U{i},1)));
        pause; %(0.1);
        for j=1:length(h)
            delete(h(j));
        end
    end