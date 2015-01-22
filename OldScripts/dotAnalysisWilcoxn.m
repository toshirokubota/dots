function [P Q] = dotAnalysisWilcoxn()
    load 'grouping.mat';
%     allTriangles = allTriangles-10;
%     triangles2 = triangles2 + 10;
    
    p1 = ranksum(points(:), allTriangles(:));
    p2 = ranksum(points(:), triangles(:));
    p3 = ranksum(allTriangles(:), triangles(:));
    fprintf('ALL: %f, %f, %f\n', p1, p2, p3);
    
    for i=1:size(points,2)
        for j=1:size(allTriangles,2)
            P(i,j)=signrank(points(:,i)-allTriangles(:,j));
        end
    end
    
    for i=1:size(points,2)
        for j=1:size(triangles,2)
            Q(i,j)=signrank(points(:,i)-triangles(:,j));
        end
    end

        