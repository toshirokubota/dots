%This file contains sets of commands that generate figures used in my
%proposal submitted to NSF in Jan. 2014.
function GroupingExample(space)
    if ~exist('space') | isempty(space)
        space = 5;
    end
%     t = load ('C:\Users\kubota\Documents\MATLAB\Fillingin\data\1.mat');
    t = load ('C:\Users\kubota\Documents\MATLAB\Fillingin\data\child.mat');
    [x y] = ind2sub(size(t.em), find(t.em));
    t.em=t.em(min(x):max(x), min(y):max(y));
    [x y] = ind2sub(size(t.em), find(t.em));
    [em2 P0] = randomSubsample(t.em, space);
    [P F E] = DotOperations('delaunay', P0);
    [P2 F2 E2 S T X] = TriangulationEdgeSaliency(P, 10, 0., 0, 0.95, 0, 100);
    thres = quantile(E2(:,3),0.9);
    [P5 E5 F5 D D2 I L] = TriangulationSegmentationSeeds(P2, F2, E2(:,3)>thres, 15, 3, size(t.em));
    figure(1); clf;
    tempDrawTriangles2(P, F);
    hold on;
    showPoints(P, [], S(:,2), 'MarkerSize', 14);
    figure(2); clf;
    tempDrawEdges(P2, E2, E2(:,3), [], '', 'LineWidth', 2);
    figure(3); clf;
    tempDrawColoredTriangles(P, F, F5(:,4), [], colormap('jet'));
    
    starts = find(F5(:,4)>0);
    Res = [];
    info = [];
    costs=[];
    for start = starts'
        [P4 E4 F4 O N] = TriangulationSegmentation(P2, F2, (E2(:,3))*1, start, [], [0 1 1 0]);
        [v stop] = max(N(:,1));
        stop = stop;
        j = O(1:stop);
        if isempty(Res)
            Res=zeros(size(F,1),1);
            Res(j) = 1;
            info = [start stop];
            costs=N(:,1);
        else
            Res(j,end+1)=1;
            info(end+1,:) = [start stop];
            costs(:,end+1) = N(:,1);
        end
    end
    h = figure(4);
    h2 = figure(5);
    clf;
    for i = 1:size(Res,2)
        figure(h);
        clf;
        tempDrawColoredTriangles(P, F, Res(:,i), [], colormap('jet'));
        figure(h2);
        clf;
        plot(costs(:,i));
        pause;
    end
    return;
    
%     N=3; %# of plots
%     del = 0.03;
%     w = (1.0-(N+1)*del)/N;
%     subplot(1,3,1);
%     subplot('Position', [del del w 1-2*del]);
%     resizeFigure(gcf, [0 500 2*size(t.im,2)*(N/(1-del*(N-1))), 2*size(t.im,1)]);
%     set(gca,'Xtick',[]); set(gca,'Ytick',[]);
%     hold on;
%     j=find(E2(:,3)>quantile(E2(:,3), 0.9));
%     tempDrawEdges(P2, E2(j,1:2), (E2(j,3)>0)+1, [], '', 'LineWidth', 2);
% %     plot([min(y) min(y) max(y) max(y) min(y)], [min(x) max(x) max(x) min(x) min(x)], 'k-');
%     xlabel('(a) Thresholded');
% 
%     subplot(1,3,2);
%     subplot('Position', [del+(w+del) del w 1-2*del]);
%     set(gca,'Xtick',[]); set(gca,'Ytick',[]);
%     imagesc(D2);
%     hold on;
%     tempDrawTriangles2(P, F, [], [], 'Color', [0 0 0]);
%     axis image;
%     set(gca,'Xtick',[]); set(gca,'Ytick',[]);
%     xlabel('(b) Distance map');
%     
%     subplot(1,3,3);
%     subplot('Position', [del+2*(w+del) del w 1-2*del]);
%     set(gca,'Xtick',[]); set(gca,'Ytick',[]);
%     hold on;
%     j = find(F5(:,4));
%     tempDrawTriangles2(P, F);
%     tempDrawColoredTriangles(P, F, F5(:,4), j', colormap('jet'));
% %     plot([min(y) min(y) max(y) max(y) min(y)], [min(x) max(x) max(x) min(x) min(x)], 'k-');
%     xlabel('(c) Seed triangles');
    
    
    