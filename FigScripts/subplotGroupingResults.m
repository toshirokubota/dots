function subplotGroupingResults(V, P, offset)
%This script makes subplots showing the first N groupings obtained by
%sortByGoodnessMeasure.

    if ~exist('offset','var') | isempty(offset)
        offset = 0;
    end
%     figure;
    cols = max(P(:,2));
    rows = max(P(:,1));
    sc=1;
    nf = 6;
    resizeFigure(gcf, [0 0 sc*nf*cols sc*rows]);
    for i=1:nf
        p = V{i+offset};
        subplot_tight(1,nf, i);
        plot(P(:,2), P(:,1), 'k.', 'Color', [0.5 0.5 0.5]); %, 'MarkerSize', 3);
        hold on;
        plot(p([1:end 1],2), p([1:end 1], 1),...
            'k-', 'LineWidth', 4);
        set(gca, 'YDir', 'reverse');
        axis image;
        axis off;
    end
