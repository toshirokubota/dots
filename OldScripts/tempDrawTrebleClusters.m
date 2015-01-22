function tempDrawTrebleClusters(P, E, T, C)
    minLen = 5;

    holdstate = ishold();
    hold on;
%     tempDrawEdges(P, E);
    for i=unique(T(:,1)')
        j=find(T(:,1)==i);
        if length(j) < minLen
            continue;
        end
        clf;
        showContours(C, [], [], [], 'LineWidth', 2, 'Color', [0 0 1]);
        hold on;
        tempDrawEdges(P, E(j,:), [], 0, 'Color', [1 0 0], 'LineWidth', 3);
        title(sprintf('%d / %d (%3.3f, %3.3f, %3.3f)', ...
            i, max(T(:,1)), mean(T(j,2:4),1)));
        fprintf('Cluster #%d:: ', i);
        fprintf('%d ', j');
        fprintf('\n');
        pause;
%         tempDrawEdges(P, E(j,:), [], 0, 'Color', [1 1 1], 'LineWidth', 3);
%         tempDrawEdges(P, E(j,:));
    end
    if holdstate==0
        hold off;
    end
    