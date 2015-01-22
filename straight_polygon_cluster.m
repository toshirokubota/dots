function [G fitvals] = straight_polygon_grouping(G, thres)
%This scripts cluster a collection of polygons using saliency measure and
%connected component analysis.
%THRES: similarity threshold.
    if ~exist('thres', 'var') || isempty(thres)
        thres = 0.9;
    end
    
    %rank each grouping based on area/maxgap^2 measure.
    fitvals=zeros(size(G));
    for i=1:length(G)
        meas = GoodnessMeasure(G{i});
        fitvals(i) = meas(1);
    end
    j=find(isnan(fitvals));
    fitvals(j)=[];
    G(j)=[];
    [fitvals j] = sort(fitvals,2,'descend');
    G = G(j);
    
    %remove near identical groupings in the consecutive ranks
    chosen=1;
    b=G{1}(:,1:2);
    for  i=2:length(fitvals)
        a = G{i}(:,1:2);
        v = setdiff(a, b, 'rows');
        score = 1 - size(v,1) /size(a,1);
        if score < thres
            b = a;
            chosen(end+1) = i;
        else
            b = union(a, b, 'rows');
        end
    end
    fprintf('%d polygons reduced to %d after filtering.\n',...
        length(G), length(chosen));
    
    G = G(chosen);
    %now compare every pair
    i=1;
    while i <= length(G)
        b = G{i}(:,1:2);
        j=i+1;
        while j<= length(G)
            a = G{j}(:,1:2);
            u = union(a,b,'rows');
            v = intersect(a,b,'rows');
            score = size(v,1)/size(u,1);
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
        fitvals(i) = meas(1);
    end
    