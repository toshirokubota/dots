function dotAnalysisPlots()
%This creates a plot figure that shows the recognition performance of three
%representations.
    load 'grouping.mat';
    allTriangles = allTriangles-10;
    triangles2 = triangles2 + 10;

    figure;
    hold on;
    for i=1:size(points,2)
        plot(points(:,i), 'r-', 'LineWidth', 2);
    end
    
    for i=1:size(allTriangles,2)
        plot(allTriangles(:,i), 'g-', 'LineWidth', 2);
    end

    for i=1:size(triangles2,2)
        plot(triangles2(:,i), 'b-', 'LineWidth', 2);
    end
    hold off;
    
    