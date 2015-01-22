function plotAllDotShapeWithNoise()

    folder = '.\MAT\';
    files = dir([folder '*.mat']);
    rows=1;
    cols=4;
    sz = [250 250];
    names = {'arrow', 'camel', 'palmtree', 'pistol', 'anchor', 'balloon', ...
        'cherries', 'star', 'car', 'dolphin', 'fish', 'umbrella', 'duck',...
        'plane', 'horse', 'shoe', 'telephone', 'squirrel', 'kangaroo', 'violin'};
    levels = {'Clean', '2', '1', '0'};
    for i=1:length(names)
        figure(1);
        clf;
        resizeFigure(gcf, [], [rows, cols], sz);
        for j=1:length(levels)
            filename = [names{i} levels{j} '.mat'];
            t = load([folder filename]);
            subplot_tight(rows, cols, j);
            plot(t.P0(:,2), t.P0(:,1), 'k.');
            axis equal;
            set(gca, 'YDir', 'reverse');
            axis off;
        end
        print('-deps', [names{i} '.eps']);
        
        figure(2);
        clf;
        resizeFigure(gcf, [], [rows, cols], sz);
        for j=1:length(levels)
            filename = [names{i} levels{j} '.mat'];
            t = load([folder filename]);
            subplot_tight(rows, cols, j);
            plot(t.P0(:,2), t.P0(:,1), '.', 'Color', [0.7 0.7 0.7]);
%             plot(t.P0(:,2), t.P0(:,1), 'k.');
            hold on;
            plot(t.outline([1:end 1],2), t.outline([1:end 1],1), 'k-', 'LineWidth', 3);
            text(500, 100, sprintf('%2.2f', t.high),...
                'HorizontalAlignment', 'center', 'FontSize', 14);
            axis equal;
            set(gca, 'YDir', 'reverse');
            axis off;
        end
        print('-deps', [names{i} '_result.eps']);
    end
   