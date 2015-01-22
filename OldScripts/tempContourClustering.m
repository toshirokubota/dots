function [C P2 F2 amap seeds] = tempContourClustering(em)

    Q = edgemap2points(em);
    C0 = ContourPrep(em); 
    C=ContourBreak(C0);
    
    [P F E S R O R2] = TriangulationCarving(Q, 5, 1);
    [P2 F2 E2] = TriangulationRefinement(S, 3);
    [dmap lmap amap] = TriangulationDistanceMap(P2, F2);
    seeds=[];
    for i=find((amap & dmap>3)')
        t = F2(i,1:3);
        Q = P2(t(:), [1 2]);
        seeds(end+1,:) = mean(Q);
    end
    C = ContourSegmentationWithTriangulation(C, seeds);
    
    tempDrawTriangles2(P2, F2);
    hold on;
    showContours(C, [], 1, [], 'LineWidth', 2);
    hold on;
    plot(seeds(:,2), seeds(:,1), 'kx', 'LineWidth', 3, 'MarkerSize', 12);
    