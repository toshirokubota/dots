function hotAirBalloons()
    addpath('C:\users\kubota\documents\matLAB\dots\');
    load 'C:\Users\kubota\Documents\MATLAB\Fillingin\data\1.mat';
    [x y] = ind2sub(size(em), find(em));
    em=em(min(x):max(x), min(y):max(y));
    im=im(min(x):max(x), min(y):max(y));
    [x y] = ind2sub(size(em), find(em));
    
    [em2 P0] = randomSubsample(em, 5);
    [P2 F2 E2 S T X] = TriangulationEdgeSaliency(P0, 10, 0., 0, 0.75, 0, 100);
    [P5 E5 F5 D D2 I L] = TriangulationSegmentationSeeds(P2, F2, E2(:,6)>4, 9.9, 5);
    starts=find(F5(:,4));
      
    rows=1; %# of rows
    cols=3; %# of columns
    delx = 0.02;
    dely = [0.02 0.02];
    w = (1.0-(cols+1)*delx)/cols;
    h = (1.0-rows*sum(dely))/rows;
    sc=2;
    
    clf;
    resizeFigure(gcf, [0 0 sc*size(em,2)*cols sc*size(em,1)*rows]);
    ic=1; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawEdges(P2, E2, E2(:,6)>4, [], '', 'LineWidth', 2);

    ic=2; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    imagesc(D2);
    set(gca, 'YDir', 'reverse'); 
    axis image;
    colormap('jet');
    
    ic=3; ir=1;
    ofx=delx+(w+delx)*(ic-1);
    ofy=1.0-ir*(sum(dely)+h)+dely(2);
    subplot(rows,cols,(ir-1)*cols+ic);
    subplot('Position', [ofx ofy w h]);
    set(gca,'Xtick',[]); set(gca,'Ytick',[]);
    hold on;
    tempDrawTriangles2(P2, F2);
    showPoints(P2, [], [], '.', 'MarkerSize', 10);
    tempDrawColoredTriangles(P2, F5(starts,1:3), F5(starts,4), []);
    