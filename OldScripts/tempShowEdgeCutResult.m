function tempShowEdgeCutResult(P, E, F, O, thres)
%This script shows interactively how region growth from two adjacent
%triangles resulted in TriangulationEdgeCut (the version uses
%TriangulationEdgeCutByGrowth.cpp dated on 1/29/2014).
%Run
%[P E F O] = TriangulationEdgeCut(P, F, 20) 
%to get the parameters to this script.
%
    N = 1:size(E,1); %[100 212 219 291] %size(E,1);
    fh = figure(1); clf;
    tempDrawTriangles2(P, F);  hold on; 
    for id=N
        if E(id,5)<thres
            continue;
        end
        j1 = E(id,3); %index to an adjacent triangle
        j2 = E(id,4); %index to the other adjacent triangle
        if j1>0
            k1 = O(j1,:);
        else
            k1 = [];
        end
        if j2>0
            k2 = O(j2,:);
        else
            k2 = [];
        end
        
        k1(find(k1<=0 | k1==j1 | k1==j2))=[];
        k2(find(k2<=0 | k2==j1 | k2==j2))=[];
        d1 = setdiff(k1, k2);
        d2 = setdiff(k2, k1);
        d3 = intersect(k1,k2);
        handles=[];
        for i=1:length(d3)
            handles(end+1)=drawColoredTriangle(fh, P, F(d3(i),:), [1 0 0]);
        end
        for i=1:length(d1)
            handles(end+1)=drawColoredTriangle(fh, P, F(d1(i),:), [1 1 0]);
        end
        for i=1:length(d2)
            handles(end+1)=drawColoredTriangle(fh, P, F(d2(i),:), [1 0 1]);
        end
        if j1>0
            handles(end+1)=drawColoredTriangle(fh, P, F(j1,:), [0 1 0]);
            fprintf('%d ', O(j1,:)); fprintf('\n');
        end
        if j2>0
            handles(end+1)=drawColoredTriangle(fh, P, F(j2,:), [0 0 1]);
            fprintf('%d ', O(j2,:)); fprintf('\n');
        end
        fprintf('%d - %d, %d, %f\n', id, j1, j2, E(id,5));
        title(sprintf('%d - %d, %d, %f', id, j1, j2, E(id,5)));
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
