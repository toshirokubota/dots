function [dmap peaks labels P F S] = tempTriangulationPartition2(C, sz, thres, srate)
    if ~exist('thres','var') | isempty(thres)
        thres = 3;
    end
    if ~exist('srate','var') | isempty(srate)
        srate = 1;
    end
    
    dthres = 3.0;
    
    [P F E S R O R2] = TriangulationCarving(C, srate, thres);
    figure(3);
    clf;
    tempDrawTriangles2(P, F, 0, []);
    
    [dmap lmap peaks] = TriangulationDistanceMap(S, sz, dthres);
    figure(1);
    clf;
    myimage(dmap);
    hold on;
    plot(S(:,2), S(:,1), 'o', 'Color', [1 1 1]);
    hold off;
    
    labels = TriangulationClustering(dmap, S, peaks);

    cmap=[0 0 0; 1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1; 1 1 1;...
        .5 .25 .25; .25 .5 .25; .25 .25 .5];
    figure(2);    
    clf;
    myimage(dmap>0);
    hold on;
    for i=0:max(labels)
        k=find(labels==i);
        if isempty(k) 
            continue; 
        end
        color = cmap(mod(i,size(cmap,1))+1,:);
        plot(S(k,2), S(k,1), 'o', 'Color', color);
        
        str = sprintf('%d', i);
        text(double(S(k,2)+3), double(S(k,1)), str, 'Color', [1 1 1]);
        
        k=find(peaks(:,4)==i);
        if isempty(k) 
            continue; 
        end
        plot(peaks(k,2), peaks(k,1), 'x', 'Color', color);
    end

    