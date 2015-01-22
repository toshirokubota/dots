function tempShowOverlapResult(P, A, B, C)
    figure(1);
    showPoints(P, [], [], 'k.', 'MarkerSize', 14);    
    hold on;
    plotTriangles(A);
    figure(2);
    showPoints(P, [], [], 'k.', 'MarkerSize', 14);    
    hold on;
    plotTriangles(B);
    figure(3);
    showPoints(P, [], [], 'k.', 'MarkerSize', 14);    
    hold on;
    plotTriangles(C);

    
function plotTriangles(T)
    for i=1:length(T)
        p = T{i};
        n = size(p,1);
        plot(p([1:n 1],2), p([1:n 1],1), 'd-', 'LineWidth', 2);
    end

