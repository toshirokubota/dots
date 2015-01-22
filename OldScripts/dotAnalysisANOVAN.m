function [p X groups] = dotAnalysisANOVAN()
    load 'grouping.mat';
    
    allTriangles = allTriangles;
    triangles2 = triangles2;
    X = [points allTriangles triangles2];
    g1 = shape_names;
    g1 = repmat(g1, [1 size(X,2)]);
    g2 = [repmat(1, [1 numel(points)]), repmat(2, [1 numel(allTriangles)]),...
        repmat(3, [1 numel(triangles2)])];
%     g3 = 1:size(X,2);
%     g3 = [1:6 1:6 1:6];
%     g3 = repmat(g3, [size(X,1) 1]);
    groups = {g1(:), g2(:)};
    
%     for i=1:numel(X)
%         fprintf('%s\t%f\t%f\t%f\n', g1{i}, g2(i), g3(i), X(i));
%     end
%     
    p = anovan(X(:), groups);
    
    