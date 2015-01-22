function [P F E P0 E0] = removeSpuriousPoints(C, thres, minlen)
%use saliency to remove spurious edge points

    if ~exist('thres','var') | isempty(thres)
        thres = 0.9;
    end
    if ~exist('minlen','var') | isempty(minlen)
        minlen = 20;
    end
    [P0 F0 E0] = TriangulationEdgeRelaxation(C, 1, 0, 3);
    [P2 E2 F2 Sal] = TriangulationEdgeSaliency(P0, F0, E0(:,5), thres);
    j=find(Sal(:,1)>minlen);
    
    P = P2(unique(E2(j,1:2)),:);
    [P F E] = DotOperations('delaunay', P);
    
    
    