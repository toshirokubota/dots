function temp()
    addpath('C:\users\kubota\documents\matLAB\dots\');
    load 'C:\Users\kubota\Documents\MATLAB\Fillingin\data\ct1.mat';    
    [em2 P0] = randomSubsample(em, 5);
    [P2 F2 E2 S T X] = TriangulationEdgeSaliency(P0, 10, 0., 0, 0.75, 0, 100);
    [P5 E5 F5 D D2 I L] = TriangulationSegmentationSeeds(P2, F2, E2(:,6)>4, 10, 10);
    starts=find(F5(:,4));
    
%     Os=[];
%     Ns=[];
%     for start = starts'
%         [P4 E4 F4 O N] = TriangulationSegmentation(P2, F2, (E2(:,5)), start, [size(F2,1)-50], [5 20 10 10 .0], [0.0 0.0 15 15]);
%         if isempty(Os)
%             Os=O;
%             Ns=N;
%         else
%             Os(:,end+1)=O;
%             Ns(:,end+1:end+size(N,2))=N;
%         end
%     end
    Res=[];
    info=[];
    stops=[59 37 50 50 76 63 22 66 60];
    for i=1:length(starts)
        start=starts(i);
        stop = stops(i);
%         [P4 E4 F4 O N] = TriangulationSegmentation(P2, F2, (E2(:,5)), start, [size(F,1)-50], [1 10 10 10 .0], [0.0 0.0 15 15]);
        [P4 E4 F4 O N] = TriangulationSegmentation(P2, F2, (E2(:,5)), start, [size(F2,1)-50], [0 1 10 1 0], [0.5 0.5 50 100]);
%         stops = find(N(:,3));
%         stops = find(N(:,3)); 
        [v id] = max(N(20:end,4));
        stop = id+20-1;
%         stops = stops(id);
%         fprintf('%d ', stops); fprintf('\n');
%         for stop = stops'
            j = O(1:stop);
            if isempty(Res)
                Res=zeros(size(F2,1),1);
                Res(j,1) = 1;
                info = [start stop];
            else
                Res(j,end+1)=1;
                info(end+1,:) = [start stop];
            end
% %         end
    end
    
    U = uniquefy(Res);
    Se = Testbed(P2, F2, Res);

    %1. canny
    %2. sampled edges
    %3. triangulation
    %4. saliency
    %5. clusters
    %6. seedss
    %7. segmentations
    %8. costs
    
    rows=1; %# of rows
    cols=4; %# of columns
    delx = 0.02;
    dely = [0.02 0.02];
    w = (1.0-(cols+1)*delx)/cols;
    h = (1.0-rows*sum(dely))/rows;
    sc=2;
    
    clf;
    ic=1; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    resizeFigure(gcf, [0 0 sc*size(em,2)*cols sc*size(em,1)*rows]);
    imagesc(im); 
    colormap('gray');
    [x y] = ind2sub(size(em), find(em));
    hold on;
    plot(y, x, '.', 'Color', [0 0 0]);
    axis image; 
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
%     set(gca, 'FontSize', 14);
%     xlabel('(a) Canny');

    ic=2; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawTriangles2(P2, F2);
    showPoints(P2, [], [], '.', 'MarkerSize', 14);
    tempDrawColoredTriangles(P2, F5(starts,1:3), F5(starts,4), [], colormap('gray'));
%     set(gca, 'FontSize', 14);
%     xlabel('(c) Triangulated');

    ic=3; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawEdges(P2, E2, E2(:,6)>4, [], '', 'LineWidth', 2);
%     set(gca, 'FontSize', 14);
%     xlabel('(e) Clustered');
    
    ic=4; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    showPoints(P2, [], [], '.', 'MarkerSize', 10, 'Color', [0 0 0]);
    colors=[1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1];
    for i=1:size(Res,2)
        Se = Testbed(P2, F2, Res(:,i));
        k = mod(i-1, size(colors,1))+1;
        j= Se>0;
        tempDrawEdges(P2, E2(j,:), [], [], '', 'LineWidth', 2, 'Color', colors(k,:));
    end
%     set(gca, 'FontSize', 14);
%     xlabel('(g) Grouped');
    
function U = uniquefy(A)
    vals = unique(A, 'rows');
    U = zeros(size(A,1),1);
    for i=1:size(vals,1)
        U(ismember(A, vals(i,:), 'rows')) = i;
    end
    
    