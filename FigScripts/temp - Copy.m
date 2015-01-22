function hotAirBalloons()
    addpath('C:\users\kubota\documents\matLAB\dots\');
    load 'C:\Users\kubota\Documents\MATLAB\Fillingin\data\ct1.mat';
    [x y] = ind2sub(size(em), find(em));
    em=em(min(x):max(x), min(y):max(y));
    [x y] = ind2sub(size(em), find(em));
    
    [em2 P0] = randomSubsample(em, 3);
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
    for start = starts'
%         [P4 E4 F4 O N] = TriangulationSegmentation(P2, F2, (E2(:,5)), start, [size(F,1)-50], [1 10 10 10 .0], [0.0 0.0 15 15]);
        [P4 E4 F4 O N] = TriangulationSegmentation(P2, F2, (E2(:,5)), start, [size(F2,1)-50], [5 20 10 10 1], [0.5 0.5 50 100]);
        stops = find(N(:,3)); 
        [v id] = max(N(stops,4));
        stops = stops(id);
        fprintf('%d ', stops); fprintf('\n');
        for stop = stops'
            j = O(1:stop);
            if isempty(Res)
                Res=zeros(size(F2,1),1);
                Res(j,1) = 1;
                info = [start stop];
            else
                Res(j,end+1)=1;
                info(end+1,:) = [start stop];
            end
        end
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
    
    rows=2; %# of rows
    cols=4; %# of columns
    delx = 0.02;
    dely = [0.01 0.07];
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
    imagesc(em==0); 
    colormap('gray');
    axis image; 
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    set(gca, 'FontSize', 14);
    xlabel('(a) Canny');

    ic=2; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    imagesc(em2==0);
    colormap('gray');
    axis image; 
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    set(gca, 'FontSize', 14);
    xlabel('(b) Sampled');

    ic=3; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawTriangles2(P2, F2);
    showPoints(P2, [], [], '.', 'MarkerSize', 14);
    set(gca, 'FontSize', 14);
    xlabel('(c) Triangulated');

    ic=4; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawEdges(P2, E2, E2(:,3), [], '', 'LineWidth', 2);
    set(gca, 'FontSize', 14);
    xlabel('(d) Saliency');
    
    ic=1; ir=2;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawEdges(P2, E2, E2(:,6)>4, [], '', 'LineWidth', 2);
    set(gca, 'FontSize', 14);
    xlabel('(e) Clustered');
    
    ic=2; ir=2;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawTriangles2(P2, F2);
    tempDrawColoredTriangles(P2, F5(starts,1:3), F5(starts,4), [], colormap('gray'));
    set(gca, 'FontSize', 14);
    xlabel('(f) Seeds');
    
    ic=3; ir=2;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawTriangles2(P2, F2);
    tempDrawEdges(P2, E2, Se>0, [], '', 'LineWidth', 2);
    set(gca, 'FontSize', 14);
    xlabel('(g) Grouped');
    
    ic=4; ir=2;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    set(gca, 'FontSize', 14);
    xlabel('(h) ');
    
function U = uniquefy(A)
    vals = unique(A, 'rows');
    U = zeros(size(A,1),1);
    for i=1:size(vals,1)
        U(ismember(A, vals(i,:), 'rows')) = i;
    end
    
    