function tempShowGroupResultV3(P0, X, Z, W, U)
%Run
% P0 = dlmread('some dot file');
% [Pt Ft Et] = TriangulationTree(P0);
% [X Y Z W V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),50);
%Then
% tempShowGroupResultV2(P0, U);
%
    tempPlotStraightMedialAxis(P0, [], Z, W);  
    cm=colormap();
    for i=1:length(U)
        [P2 G] = ClosedPolygons(U{i});
        h=[];

        q = W{i};
        p = U{i};
        g = plot(q([1:end 1],2), q([1:end 1], 1), 'rx-', 'LineWidth', 2);
%         h = plot(p([1:end 1],2), p([1:end 1], 1), 'kx-', 'LineWidth', 2);
        for j=1:length(G)
            p=G{j};
            k = mod(j-1, size(cm,1)) + 1;
            h(j) = plot(p([1:end 1],2), p([1:end 1], 1), '-', 'Color', cm(k,:), 'LineWidth', 2);
    %         patch(p(:,2), p(:, 1), cm(k,:));
        end
        title(sprintf('%d %d', i, size(U{i},1)));
        pause; %(0.1);
        for j=1:length(h)
            delete(h(j));
        end
        delete(g);
    end
    
    