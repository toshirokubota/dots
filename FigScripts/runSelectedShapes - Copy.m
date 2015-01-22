function runSelectedShapes()
    names = {'arrow', 'camel', 'palmtree', 'pistol', 'anchor', 'balloon', ...
        'cherries', 'star', 'car', 'dolphin', 'fish', 'umbrella', 'duck',...
        'plane', 'horse', 'shoe', 'telephone', 'squirrel', 'kangaroo', 'violin'};
    level = [2 1 0 2 0 2 1 1 2 0 1 1 2 1 2 0];
    
    folder = '..\MAT Files of How Well Algorithm Did\';
    
% %     figure(1);
%     resizeFigure(figure(1), [], [4 4], [200 200]);
%     clf;
%     resizeFigure(figure(2), [], [4 4], [200 200]);
%     clf;
% %     figure(2); clf;
    
    h=0.21;
    w=0.21;
    ofx=0.04;
    ofy=0.04;
    for i=1:length(names)
%         for level=0:2
%             filename = [names{i} '.shape_', num2str(level) '.dots.mat'];
            filename = [names{i} '.shape_', num2str(0) '.dots.mat'];
            fprintf('%d: %s\n', i, filename);
            t = load ([folder filename]);
            P0 = t.P0(find(t.P0(:,3)~=1),:);
            clear t;

            [Pt Ft Et] = TriangulationTree(P0);
            [X Y Z W V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),50);
            [high id outline] = tempShowGroupResultV2(P0, U);
            save([names{i} 'Clean'], 'P0', 'Pt', 'Ft', 'Et', ...
                'X', 'Y', 'Z', 'W', 'V', 'U', 'high', 'id', 'outline');
%             save([names{i} num2str(level)], 'P0', 'Pt', 'Ft', 'Et', ...
%                 'X', 'Y', 'Z', 'W', 'V', 'U', 'high', 'id', 'outline');
%         row = floor((i-1)/4)+1;
%         col = mod((i-1),4) + 1;
%         figure(1);
%         subplot_tight(4,4,i);
%         plot(P0(:,2), P0(:,1), 'k.'); %, 'MarkerSize', 10);
%         set(gca, 'YDir', 'reverse');
%         axis image;
%         axis off;
% 
%         figure(2);
%         subplot_tight(4,4,i);
%         plot(P0(:,2), P0(:,1), 'k.'); %, 'MarkerSize', 10);
%         hold on;
%         plot(outline([1:end 1],2), outline([1:end 1],1), 'r-', 'LineWidth', 2);
%         set(gca, 'YDir', 'reverse');
%         axis image;
%         axis off;        
%         fprintf('%d: %s %f %d\n', i, filename, high, id);
        end
    end
    