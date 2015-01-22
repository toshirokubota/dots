function tempDrawFaceTree(T)
% this method plots a tree computed in TriangulationFaceMST
% (TriangulationTree.dll). [11/15/2013]
    
    holdstate = ishold();
    if holdstate==0
        clf;
    end
    hold on;
    for i=1:size(T,1)
        x=T(i,[1 3]);
        y=T(i,[2 4]);
        plot(y, x, 'b.-');
    end
    axis image;
    set(gca, 'YDir', 'reverse');    
    if holdstate==0
        hold off;
    end
