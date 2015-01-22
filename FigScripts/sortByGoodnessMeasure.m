function [V scores Q] = sortByGoodnessMeasure(U)
%This script takes a set of polygons in U (a cell of matrices), then
%1. remove the duplicates
%2. splits at common edges using ClosedPolygon,
%3. and sort the split polygons using GoodnessMeasure.
    Q = uniquePolygons(U);
    V={};
    scores=[];
    thres = 0.5;
    lenthres=20;
    for i=1:length(Q)
        [P2 G] = ClosedPolygons(Q{i});
        for j=1:length(G)
            if size(G{j})<lenthres
                continue;
            end
            s = GoodnessMeasure(G{j});
%             V{end+1}=G{j};
%             scores(end+1) = s;
            worse=[];
            better=[];
            for k=1:length(V)
                area = OverlapArea(V{k},G{j});
                t = area(3)/(area(1)+area(2)-area(3));
                if t > thres
                    if s > scores(k)
                        worse(end+1)=k;
                    else
                        better(end+1)=k;
                    end
                end
            end
            scores(worse)=[];
            V(worse)=[];
            if isempty(better)
                scores(end+1) = s;
                V{end+1}=G{j};
            end
        end
    end
    
    [scores si] = sort(scores, 'descend');
    V=V(si);
        
