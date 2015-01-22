%This file contains sets of commands that generate figures used in my
%proposal submitted to NSF in Jan. 2014.
function TriangulationExample(space)
    if ~exist('space') | isempty(space)
        space = 5;
    end
    t = load ('C:\Users\kubota\Documents\MATLAB\Fillingin\data\1.mat');
    [x y] = ind2sub(size(t.em), find(t.em));
    t.em=t.em(min(x):max(x), min(y):max(y));
    [x y] = ind2sub(size(t.em), find(t.em));
    [em2 P0] = randomSubsample(t.em, space);
    [P F E] = DotOperations('delaunay', P0);
    [P2 F2 E2 S T X] = TriangulationEdgeSaliency(P, 10, 0., 0, 0.95, 0, 100);
    
    N=3; %# of plots
    del = 0.03;
    w = (1.0-(N+1)*del)/N;
    subplot(1,3,1);
    subplot('Position', [del del w 1-2*del]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    resizeFigure(gcf, [0 500 2*size(t.im,2)*(N/(1-del*(N-1))), 2*size(t.im,1)]);
    hold on;
    showPoints(P2, [], S(:,1), 'MarkerSize', 10);
    xlabel('(a) Structural fitness');

    subplot(1,3,2);
    subplot('Position', [del+(w+del) del w 1-2*del]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    j=find(E2(:,3)>0);
    tempDrawEdges(P2, E2(j,1:2), E2(j,3), [], '', 'LineWidth', 2);
%     plot([min(y) min(y) max(y) max(y) min(y)], [min(x) max(x) max(x) min(x) min(x)], 'k-');
    xlabel('(b) Max. saliency');
    
    subplot(1,3,3);
    subplot('Position', [del+2*(w+del) del w 1-2*del]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    j=find(E2(:,3)>quantile(E2(:,3), 0.9));
    tempDrawEdges(P2, E2(j,1:2), (E2(j,3)>0)+1, [], '', 'LineWidth', 2);
%     plot([min(y) min(y) max(y) max(y) min(y)], [min(x) max(x) max(x) min(x) min(x)], 'k-');
    xlabel('(c) Thresholded');
    
    
    