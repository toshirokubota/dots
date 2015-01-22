function [G fitvals Ga Gb] = straight_polygon_cluster(G, thres)
%This scripts cluster a collection of polygons using saliency measure and
%connected component analysis.
%THRES: similarity threshold.
    if ~exist('thres', 'var') || isempty(thres)
        thres = 0.9;
    end
    mode = 2; %1 for max, 2 for sum of gap^2.
    
    %rank each grouping based on area/maxgap^2 measure.
    fitvals=zeros(size(G));
    for i=1:length(G)
        meas = GoodnessMeasure(G{i});
        fitvals(i) = meas(mode);
    end
    j=find(isnan(fitvals));
    fitvals(j)=[];
    G(j)=[];
    [fitvals j] = sort(fitvals,2,'descend');
    G = G(j);
    Ga = G;
    
    %remove near identical groupings in the consecutive ranks
    chosen=1;
    b=G{1}(:,1:2);
    for  i=2:length(fitvals)
        a = G{i}(:,1:2);
        score = polygonDiff(a, b);
        if score < thres
            b = a;
            chosen(end+1) = i;
        end
    end
    fprintf('%d polygons reduced to %d after filtering.\n',...
        length(G), length(chosen));
    
    G = G(chosen);
    Gb = G;
    
    %now compare every pair
    i=1;
    while i <= length(G)
        b = G{i}(:,1:2);
        j=i+1;
        while j<= length(G)
            a = G{j}(:,1:2);
            score = polygonDiff(a, b);
            if score < thres
                j = j + 1;
            else
                G(j) = [];
            end
        end
        i = i + 1;
    end
    fprintf('%d polygons reduced to %d after filtering.\n',...
        length(chosen), length(G));
    for i=1:length(G)
        meas = GoodnessMeasure(G{i});
        fitvals(i) = meas(mode);
    end
    
function s = polygonDiff(a, b)
    u = union(a, b, 'rows');
    v = intersect(a, b, 'rows');
    s = size(v,1) / size(u,1);
        