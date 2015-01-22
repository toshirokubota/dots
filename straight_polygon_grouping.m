function G = straight_polygon_grouping(P, dispOn)
    if ~exist('P', 'var') || isempty(P)
        P = readShape('..\shapes\dolphin.shape');
        P = P(1:20:end,:); %sub-sample points
    end
    if ~exist('dispOn', 'var') || isempty(dispOn)
        dispOn = 0;
    end
    
    %find grouping from straight-polygon-transform
    [Pt Ft Et] = TriangulationTree(P);
    [X Y Z G V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),200);
    G={};
    for i=1:length(U)
        [P2 G2] = ClosedPolygons(U{i});
        G(end+1:end+length(G2))=G2;
    end
    
    if dispOn
        showGroupings(Pt, Et(find(Et(:,3)),:), G, 10);
    end
    