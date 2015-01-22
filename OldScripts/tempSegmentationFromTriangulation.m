function [P F S dmap lmap tmap labels seeds C] = tempSegmentationFromTriangulation(em, thres)
    if ~exist('thres','var') | isempty(thres)
        thres = 3;
    end
    Q = edgemap2points(em);
    C = ContourPrep(em); 
%     C=ContourBreak(C0);
    
    [P F E S R O R2] = TriangulationCarving(Q, 5, thres);
    [dmap lmap tmap centr] = TriangulationDistanceMap(S, size(em), 0);
%     [labels seeds] = TriangulationSegmentation(dmap, tmap);
    labels='disabled'; seeds='disabled';
    
%     clf;
%     tempShowSegmentationLabels(labels, seeds, C);
    