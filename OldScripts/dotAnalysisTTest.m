function [p X groups] = dotAnalysisTTest()
    load 'grouping.mat';
%     allTriangles = allTriangles-10;
%     triangles2 = triangles2 + 10;
    
    alpha = 0.05;
    tail = 'both';
    [h1 p1 ci1] = ttest2(points(:), allTriangles(:), alpha, tail);
    [h2 p2 ci2] = ttest2(points(:), triangles2(:), alpha, tail);
    [h3 p3 ci3] = ttest2(allTriangles(:), triangles2(:), alpha, tail);
    fprintf('ALL: %f, %f, %f\n', p1, p2, p3);

    for i=1:size(points,1)
        [h1 p1 ci1] = ttest2(points(i,:), allTriangles(i,:), alpha, tail);
        [h2 p2 ci2] = ttest2(points(i,:), triangles2(i,:), alpha, tail);
        [h3 p3 ci3] = ttest2(allTriangles(i,:), triangles2(i,:), alpha, tail);
        fprintf('%s: %f, %f, %f\n', shape_names{i}, p1, p2, p3);
    end
        