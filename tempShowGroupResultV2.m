function [high high_id outline] = EvaluateGroupResultV2(P0, U, display)
%Run
% P0 = dlmread('some dot file');
% [Pt Ft Et] = TriangulationTree(P0);
% [X Y Z W V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),50);
%Then
% tempShowGroupResultV2(P0, U);
%
    if ~exist('display', 'var') | isempty(display)
        display = 0;
    end
    
    if display
        hold off;
        showPoints(P0, [], [], 'k.', 'MarkerSize', 18);
        hold on;
%         cm = colormap('colorcube');
        cm=[1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1];
    end
    if size(P0,2)>=3
        shape = P0(find(P0(:,3)==0),1:2);
    else
        shape = [];
    end
    high = 0;
    high_id = 0;
    outline=[];
    for i=1:length(U)
        [P2 G] = ClosedPolygons(U{i});
        h=[];
        scores=[0];
        if ~isempty(shape)
            for j=1:length(G)
                p=G{j};
                area = OverlapArea(p, shape);
                scores(j) = area(3)/(area(1)+area(2)-area(3));
            end
        end
        
        [val id] = max(scores);
        if val > high
            high = val;
            high_id = i;
            outline = G{id};
        end
        if display
            for j=1:length(G)
                p=G{j};
                k = mod(j-1, size(cm,1)) + 1;
                h(j) = plot(p([1:end 1],2), p([1:end 1], 1), '-', 'Color', cm(k,:), 'LineWidth', 4);
        %         patch(p(:,2), p(:, 1), cm(k,:));
            end
            title(sprintf('%d %d %f', i, size(U{i},1), max(scores)));
            pause; %(0.1);
            for j=1:length(h)
                delete(h(j));
            end
        end
    end
%     if ~isempty(outline)
%         clf;
%         showPoints(P0, [], [], 'k.', 'MarkerSize', 14);
%         hold on;
%         plot(outline([1:end 1],2), outline([1:end 1], 1), 'r-', 'LineWidth', 3);
%         title(sprintf('%d %f\n', high_id, high));
%         axis off;
%     end
    
    