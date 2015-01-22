function tempShowGroupedPoints(P, F, G, vals, vals2, n)

    if ~exist('vals','var') | isempty(vals)
        vals = unique(G(:)); %show all of them
    end
    if ~exist('vals2','var') | isempty(vals2)
        vals2 = zeros(size(vals)); %show all of them
    end
    if ~exist('n', 'var') | isempty(n)
        n = 0;
    end
    figure;
    tempDrawTriangles2(P, F);
    hold on;
    fprintf('There are %d groups.\n', length(vals));
    for i=1:length(vals)
        pnts = P(find(G==vals(i)),:);
        x = pnts(:,2);
        y = pnts(:,1);
        if(i>n)
            h = plot(x, y, 'r.', 'MarkerSize', 14);
            title(sprintf('%d, %d: %f %d', i, vals(i), vals2(i), length(x)));
            pause;
            h = plot(x, y, 'g.', 'MarkerSize', 14);
        else
            h = plot(x, y, 'g.', 'MarkerSize', 14);
        end
    end
       