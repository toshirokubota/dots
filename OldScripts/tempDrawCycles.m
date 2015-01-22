function tempDrawCycles(cycles, seeds, starts, P)
    plot(P(:,2), P(:,1), 'o', 'LineWidth', 2, 'Color', [0.7 0.7 0.7]);
    hold on;
    colors='rgbkcmy';
    for i=1:length(cycles)
        p = P(cycles{i},:);
        p(end+1,:) = p(1,:);
        ls = [colors(mod(i-1,7)+1), '-'];
        plot(p(:,2), p(:,1), ls, 'LineWidth', 2);
        mid = mean(P(starts(i,1:2),1:2));
        ms = [colors(mod(i-1,7)+1), 'x'];
%         plot(mid(2), mid(1), ms, 'LineWidth', 2, 'MarkerSize', 10);
        plot(starts(i,2), starts(i,1), ms, 'LineWidth', 2, 'MarkerSize', 10);
        ms = [colors(mod(i-1,7)+1), 'o'];
        plot(seeds(i,2), seeds(i,1), ms, 'LineWidth', 2, 'MarkerSize', 10);
    end
    axis image;
    set(gca, 'YDir', 'reverse');    
    