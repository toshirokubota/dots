function tempShowEdgeCutResult2(P, E, F, O, thres)
%This script shows interactively how region grows from initial region with
%similar triangles. The result is computed by TriangulationEdgeCut (the version uses
%TriangulationEdgeCutByGrowthV2.cpp dated on 2/5/2014).
%Run
%[P E F O] = TriangulationEdgeCut(P, F, 20) 
%to get the parameters to this script.
%
    fh = figure(1); clf;
    tempDrawTriangles2(P, F);  hold on; 
    for j=1:length(O)
        handles=[];
        idx=O{j};
        for i=1:length(idx)
            handles(end+1)=drawColoredTriangle(fh, P, F(idx(i),:), [1 0 0]);
        end
%         fprintf('%d - %d, %d, %f\n', id, j1, j2, E(id,5));
        title(sprintf('%d', j));
        pause;
        for i=1:length(handles)
            delete(handles(i));
        end
    end
    
    
function h = drawColoredTriangle(fh, P, t, color)
    t = [t(1:3) t(1)];
    Q = double(P([t(:)' t(1)], [1 2]));
    figure(fh);
    h = patch(Q(:,2), Q(:,1), color);
