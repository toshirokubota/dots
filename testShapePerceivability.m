function [val, outline] = testShapePerceivability(P, t, display)

    if ~exist('display','var') | isempty(display)
        display = 0;
    end
    
    [Pt Ft Et] = TriangulationTree(P);

    [X Y Z W V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),50);
    
    scores = zeros(size(U));
    for i=1:length(U)
        scores(i) = calculateScore(U{i}, t);
    end
    [val maxi] = max(scores);
    outline = P(U{maxi},:);
    if display
        shape = P(find(t==0),:);
        figure(1);
        hold off;
        showPoints(P, [], [], '.', 'MarkerSize', 14);
        figure(2);
        hold off;
        showPoints(P, [], [], '.', 'MarkerSize', 14);
        hold on;
        plot(shape([1:length(shape) 1],2), shape([1:length(shape) 1],1),...
        'g-', 'LineWidth', 2);
        plot(outline([1:length(outline) 1],2), outline([1:length(outline) 1],1),...
        'r-', 'LineWidth', 2);
        hold off;
        title(sprintf('%d, %f', maxi, val));
        pause;
    end
    
    
function score = calculateScore(idx, t) 
    n = length(idx);
    m = length(find(t==0));
    idx = unique(idx);
    if isempty(j)
        score = 0;
    else
        k1 = find(idx<=length(t));
        k2 = find(t(idx(k1))==0);
        score = length(k2) / (n + m - length(k2));
    end
