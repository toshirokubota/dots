function G = neighborhoodGraph(P0)
%This script (as an experiment) tries to derive a neighborhood graph
%simialr to the relative neighborhood graph of (Toussaint).
%The graph contains all the traced polygons obtained by the algorithm.

    [Pt Ft Et] = TriangulationTree(P0);
    [X Y Z W V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),1000, 100);
    Q = U; %uniquePolygons(U);
%     [U2 scores Q] = sortByGoodnessMeasure(U);
    G={};
    for i=1:length(Q)
        area = DotOperations('area', W{i});
        if area > 1
            [P2 g] = ClosedPolygons(Q{i});
            G(end+1:end+length(g))=g;
        end
    end
%     G = uniquePolygons(G);
    figure(1); clf;
    showPoints(P0, [], [], 'k.', 'MarkerSize', 14);
    hold on;
    tempDrawTriangles2(Pt, Ft);
    figure(2); clf;
    showPoints(P0, [], [], 'k.', 'MarkerSize', 14);
    tempPlotStraightMedialAxis(P0, X, Z, W);
    figure(3); clf;
    showPoints(P0, [], [], 'k.', 'MarkerSize', 14);
    hold on;
    for i=1:length(G)
        p = G{i};
        plot(p([1:end 1],2), p([1:end 1],1), 'b-', 'LineWidth', 2);
    end
    figure(4); clf;
    showPoints(P0, [], [], 'k.', 'MarkerSize', 14);
    hold on;
    for i=1:length(Q)
        figure(4);
        title(sprintf('%d, %d', i, size(p,1)));
        area = DotOperations('area', W{i});
        if area > 1
            p = W{i};
            h(1) = plot(p([1:end 1],2), p([1:end 1],1), 'g-', 'LineWidth', 2);
            q = Q{i};
            h(2) = plot(q([1:end 1],2), q([1:end 1],1), 'b-', 'LineWidth', 2);
            pause;
            delete(h(1));
            delete(h(2));
        end
    end
    