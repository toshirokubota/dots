%This file contains sets of commands that generate figures used in my
%proposal submitted to NSF in Jan. 2014.
function TriangulationExample()
    t = load ('C:\Users\kubota\Documents\MATLAB\Fillingin\data\1.mat');
    [x y] = ind2sub(size(t.em), find(t.em));
    t.em=t.em(min(x):max(x), min(y):max(y));
    [x y] = ind2sub(size(t.em), find(t.em));
    
    N=3; %# of plots
    del = 0.03;
    w = (1.0-(N+1)*del)/N;
    subplot(1,3,1);
    subplot('Position', [del del w 1-2*del]);
    resizeFigure(gcf, [0 500 2*size(t.im,2)*(N/(1-del*(N-1))), 2*size(t.im,1)]);
    imagesc(t.em==0);
    colormap(gca, 'gray');
    axis image;
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    a1 = axis;
    xlabel('(a) Canny result');

    [em2 P0] = randomSubsample(t.em, 5);
    subplot(1,3,2);
    subplot('Position', [del+(w+del) del w 1-2*del]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    showPoints(P0, [], [], '.', 'MarkerSize', 10);
    a2 = axis;
%     axis([a2(1) a1(2) a2(3) a1(4)]);
    %draw a bounding box manually...
    plot([min(y) min(y) max(y) max(y) min(y)], [min(x) max(x) max(x) min(x) min(x)], 'k-');
    xlabel('(b) Sampled features');
    
    [P F E] = DotOperations('delaunay', P0);
    subplot(1,3,3);
    subplot('Position', [del+2*(w+del) del w 1-2*del]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawTriangles2(P, F);
    showPoints(P0, [], [], '.', 'MarkerSize', 10);
    a3 = axis;
%     axis([a3(1) a1(2) a3(3) a1(4)]);
    %draw a bounding box manually...
    plot([min(y) min(y) max(y) max(y) min(y)], [min(x) max(x) max(x) min(x) min(x)], 'k-');
    xlabel('(c) Triangulation');
    
    
    