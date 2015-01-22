function plotDotShapeWithNNoise(name)
% make four plots with a shape with various noise level.
%it reads three files: name.shape_0_dots.txt, name.shape_1_dots.txt, and 
%name.shape_2_dots.txt where 'name' is the parameter being passed to this
%script. Files will be searched in ..\shapeWithDots.
%for each file, it runs the grouping algorithm and measure the accuracy of
%the grouping by the overlapping area.

    folder = '..\shapeWithNoise\';
    addpath('..');
    P={};
    for i=1:3
        pnts = dlmread([folder name '.shape_' num2str(3-i) '_dots.txt']);
        if i==1
            P{1} = pnts(find(pnts(:,3)~=1),:);
        end
        P{i+1} = pnts;
    end
    
    clf;
    resizeFigure(gcf, [], [1 4], [250 250]);
    w = 0.23;
    h = 0.96;
    ofx = 0.02;
    ofy = 0.02;
    for i=1:length(P)
        P0 = P{i};
        [Pt Ft Et] = TriangulationTree(P0);
        [X Y Z W V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),50);
        [high id outline] = EvaluateGroupResult(P0, U);
        subplot(1,4,i);
        subplot('position', [(w+ofx)*(i-1) ofy w h]);
        plot(P0(:,2), P0(:,1), 'k.', 'MarkerSize', 12);
        hold on;
        plot(outline([1:end 1],2), outline([1:end 1],1), 'r-', 'LineWidth', 2);
        set(gca, 'YDir', 'reverse');
        axis image;
        a = axis();
        text((a(1)+a(2))/2, a(3)+10, sprintf('%f,%d', high, id), 'HorizontalAlignment', 'center');
        axis off;
    end
    
function [high high_id outline] = EvaluateGroupResult(P0, U)
%Run
% P0 = dlmread('some dot file');
% [Pt Ft Et] = TriangulationTree(P0);
% [X Y Z W V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),50);
%Then
% tempShowGroupResultV2(P0, U);
%
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
    end
    
    
    