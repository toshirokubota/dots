function tempShowGroupedTriangles(P, F, G, vals, n, sal)

    if ~exist('vals','var') | isempty(vals)
        vals = unique(G(:)); %show all of them
    end
    if ~exist('n', 'var') | isempty(n)
        n = 0;
    end
    fig = figure;
    tempDrawTriangles2(P, F);
    hold on;
    if exist('sal','var') && size(sal,1)==size(P,1)
        showPoints(P, [], sal, 'MarkerSize', 14);
    else
        showPoints(P, [], [], '.', 'MarkerSize', 14);
    end
    fprintf('There are %d groups.\n', length(vals));
    for i=1:size(G,1)
        t = F(G(i),:);
        Q = P([t(:)' t(1)], [1 2]);
        if(i>=n)
            figure(fig);
            h = plot(Q(:,2), Q(:,1), 'r-', 'LineWidth', 2);
            title(sprintf('%d, %d: %f', i, G(i), vals(i)));
            pause;
            delete(h);
            figure(fig);
            h = plot(Q(:,2), Q(:,1), 'g-', 'LineWidth', 2);
        else
            figure(fig);
            h = plot(Q(:,2), Q(:,1), 'g-', 'LineWidth', 2);
        end
    end
       