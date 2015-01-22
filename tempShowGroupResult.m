function tempShowGroupResult(P, G)

    showPoints(P, [], [], 'k.', 'MarkerSize', 18);
    hold on;
    cm = colormap('colorcube');
    for i=1:length(G)
        p=G{i};
%         if length(p) > 100
%             continue;
%         end
        title(sprintf('%d %d', i, size(p,1)));
        k = mod(i-1, size(cm,1)) + 1;
        h = plot(p([1:end 1],2), p([1:end 1], 1), '-', 'Color', cm(k,:), 'LineWidth', 2);
%         patch(p(:,2), p(:, 1), cm(k,:));
        pause; %(0.1);
        delete(h);
    end
    hold off;
    