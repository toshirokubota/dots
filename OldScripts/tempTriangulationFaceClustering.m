function [P2 F2 L dmap amap] = tempTriangulationFaceClustering(em, thres)
    if ~exist('thres','var') | isempty(thres)
        thres = 3;
    end
    Q = edgemap2points(em);
    C0 = ContourPrep(em); 
    C=ContourBreak(C0);
    
    [P F E S R O R2] = TriangulationCarving(Q, 5, thres);
    [P2 F2 E2] = TriangulationRefinement(S, 3);
    [dmap lmap amap] = TriangulationDistanceMap(P2, F2);
    sel = lmap; %lmap & dmap>=1;
    L = TriangulationSegmentation(P2, F2, sel, dmap);
    
    clf;
%     tempDrawColoredTriangles(P2, F2, L);
%     hold on;
    tempDrawTriangles2(P2, F2, 0, [], 'LineWidth', 1);
%     tempDrawTriangles2(P2, F2, 0, find(sel'), 'Color', [0 0 0], 'LineWidth', 2);
%     red=0:1/(max(dmap)+1):1;
%     cmap=[red' zeros([length(red) 2])];
%     tempDrawColoredTriangles(P2, F2, dmap);
    showContours(C, [], [], [], 'r-', 'LineWidth', 2);
    