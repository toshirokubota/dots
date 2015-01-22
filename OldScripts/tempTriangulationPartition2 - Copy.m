function [dmap peaks points] = tempTriangulationPartition2(C, sz, thres, srate)
    if ~exist('thres','var') | isempty(thres)
        thres = 3;
    end
    if ~exist('srate','var') | isempty(srate)
        srate = 1;
    end
%     Q = edgemap2points(em);
%     C0 = ContourPrep(em); 
%     C=ContourBreak(C0);
    
    dthres = 3.0;
    
    [P F E S R O R2] = TriangulationCarving(C, srate, thres);
    figure(3);
    clf;
    tempDrawTriangles2(P, F, 0, []);
    
    [dmap lmap peaks] = TriangulationDistanceMap(S, sz, dthres);
    figure(1);
    myimage(dmap);
    hold on;
    plot(S(:,2), S(:,1), 'o', 'Color', [1 1 1]);
    hold off;
    for i=1:max(peaks(:,4))
        k=find(peaks(:,4)==i);
        if isempty(k) 
            continue; 
        end
         
        [surf surf0 region] = TriangulationClustering(dmap, peaks(k,:));
        j = find(surf);
        [x y] = ind2sub(size(dmap), j);
        points{i}=[x y];
        figure(2);
        clf;
        myimage(region);
        hold on;
        plot(peaks(k,2), peaks(k,1), 'x', 'Color', [1 1 1]);
        plot(y, x, 'o', 'Color', [1 1 1]);
        showContours(C, [], [], [], 'r-', 'LineWidth', 2);
        pause;
    end
    
