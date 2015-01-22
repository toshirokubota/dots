function [p X groups] = dotAnalysisNonparametric()
%perform Kruskal-Wallis on shape recognition data
    load 'grouping.mat';
    
    X = [points allTriangles triangles2];
    grp = [repmat(1, [1 numel(points)]), repmat(2, [1 numel(allTriangles)]),...
        repmat(3, [1 numel(triangles2)])];
    [pkw tab stat] = kruskalwallis(X, grp);
    
    for i=1:20
        pmw(i,1)=ranksum(points(i,:), allTriangles(i,:));
        pmw(i,2)=ranksum(points(i,:), triangles2(i,:));
        pmw(i,3)=ranksum(triangles2(i,:), allTriangles(i,:));
        fprintf('%s\t%f\t%f\t%f\n', shape_names{i}, pmw(i,:));
    end
    