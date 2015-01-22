function tempShowDigraph(C, A)
%     hold off;
%     showContours(C, [], [], [1], 'LineWidth', 2, 'Color', [1 0 0]);
    for i=1:length(C)
        loc(i,1:2) = double(representativePosition(C{i}(:,[2 1])));
    end
    plot(loc(:,1), loc(:,2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    hold on;
    text(loc(:,1), loc(:,2)+2, num2str([1:length(C)]'));
    for i=1:size(A,1)
        cids=find(A(i,:)<0);
        for j=1:length(cids)
            arrow(loc(cids(j),:), loc(i,:), 'Width', 1, 'Length', 10); %,...
%                 'BaseAngle', 15, 'TipAngle', 30);
        end
    end
    axis image;
    set(gca, 'YDir', 'reverse');
    hold off;
        