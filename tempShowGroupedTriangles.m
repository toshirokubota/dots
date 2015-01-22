function tempShowGroupedTriangles(P, F, G, vals, n, sal)

    if ~exist('vals','var') | isempty(vals)
        vals = unique(G(:)); %show all of them
    end
    if ~exist('n', 'var') | isempty(n)
        n = 1:size(G,1);
    end
    n = [n n(end)+1:size(G,1)];
    
    fig = figure;
    tempDrawTriangles2(P, F);
    hold on;
    if exist('sal','var') && size(sal,1)==size(P,1)
        showPoints(P, [], sal, 'MarkerSize', 14);
    else
        showPoints(P, [], [], '.', 'MarkerSize', 14);
    end
    fprintf('There are %d groups.\n', length(vals));
    j=1;
    Q=[];
    for i=1:length(n)
        figure(fig);
        title(sprintf('%d, %d: %f', n(i), G(n(i)), vals(n(i))));
        while(j<=n(i))
            if ~isempty(Q) %not the firt time, recolor red triangle to green
                h = plot(Q(:,2), Q(:,1), 'g-', 'LineWidth', 2);
            end
            t = F(G(j),:);
            Q = P([t(:)' t(1)], [1 2]);
            figure(fig);
            h = plot(Q(:,2), Q(:,1), 'r-', 'LineWidth', 2);
            j=j+1;
        end
        pause;
    end
       