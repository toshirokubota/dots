function tempIterateEdgeRemoval(P, E, R)
%this script replay the process of edge removal (in depth-first order).
%this was intended to aid debugging of Triangulationcurving.
%Run
%[P F E D R] = TriangulationCurving(...);
%Then, do
%tempIterateEdgeRemoval(P, E, R);
%


    figure;
    hold on;
    %plot(P(:,2), P(:,1), '.', 'MarkerSize', 30);
%     text(double(P(:,2)), double(P(:,1))+3, num2str((1:size(P,1))'));
    for i=1:size(E,1)
        t = E(i,1:2);
        Q = P(t(:)', [1 2]);
        plot(Q(:,2), Q(:,1), 'b-', 'LineWidth', 1);
    end
    axis image;
    set(gca, 'YDir', 'reverse');    
    
    for i=1:size(R,1)
        if i>0
            pause(0.1);
        end
        t = R(i,1:2); %T(R(i),1:3);
        Q = P(t(:)', [1 2]);
        plot(Q(:,2), Q(:,1), 'g-', 'LineWidth', 2);
        if i>1
            t = R(i-1,1:2); %T(R(i-1),1:3);
            Q = P(t(:)', [1 2]);
            plot(Q(:,2), Q(:,1), 'r-', 'LineWidth', 2);
        end
        title(num2str(i));
    end
    hold off;
    
        