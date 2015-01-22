function plotResultsOfImages(names)
%NAMES is a cell array containing image names.

    if ~exist('names','var') | isempty(names)
        names = {'1', '111B', '91001', '106019', '124042', '169096',...
            '140B', 'ct4', '5', '7B', '11'};
    end

    folder = '.'; %'C:\Data\images\Data01\';
    for i=1:length(names)
        name = names{i};
%         im = imread([folder name '.png']);
%         em = imread([folder name '-canny.png']);
%         [em2 P0] = randomSubsample(em, 4);
%         [Pt Ft Et] = TriangulationTree(P0);
%         [X Y Z W V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),20);
%         [U2 scores Q] = sortByGoodnessMeasure(U);

        load(name);
        
        figure(1); clf;
        cols = size(im,2);
        rows = size(im,1);
        sc=1;
        offset = 0;
        np = 6; 
        nf = np + 2;
        resizeFigure(gcf, [0 0 sc*nf*cols sc*rows]);
        subplot_tight(1,nf,1);
        imagesc(im);
        axis image;
        axis off;
        subplot_tight(1,nf,2);
        imagesc(~em);
        axis image;
        axis off;
        colormap('gray');
        for i=1:np
            p = U2{i+offset};
            subplot_tight(1,nf, i+2);
            plot(P0(:,2), P0(:,1), 'k.', 'Color', [0.5 0.5 0.5], 'MarkerSize', 3);
            hold on;
            plot(p([1:end 1],2), p([1:end 1], 1),...
                'k-', 'LineWidth', 2);
            set(gca, 'YDir', 'reverse');
            axis image;
            axis off;
        end 
        print('-deps2', [name '.eps']);
%         save(name, 'im', 'em', 'em2', 'P0', 'Pt', 'Et', 'Ft', ...
%             'U', 'V', 'W', 'X', 'Y', 'Z', 'Q', 'U2', 'scores');
%         pause;
    end