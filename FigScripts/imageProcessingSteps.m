function [P0 Pt Et Ft em2] = imageProcessingSteps(name)
% make four plots showing pre-processing steps from an image to MST.
% NAME is the header file name that will be used to load both gray scale
% and canny images.
%Good names to use are: 1, 111B, 
    addpath('..');
    folder = 'C:\Data\images\Data01\';
    
    clf;
    w = 0.23;
    h = 0.96;
    ofx = 0.02;
    ofy = 0.04;
    oft = -5;
    im = imread([folder name '.png']);
    em = imread([folder name '-canny.png']);
    [em2 P0] = randomSubsample(em, 4);
    [Pt Ft Et] = TriangulationTree(P0);   
    
    resizeFigure(gcf, [], [1 4], size(im)*2);
    subplot(1,4,1);
    subplot('position', [0, ofy, w, h]);
    imagesc(im);
    ax = axis();
    axis image; 
    axis off;
    setLabel(axis(), '(a) image', oft);

    subplot(1,4,2);
    subplot('position', [w+ofx, ofy, w, h]);
    imagesc(em==0);
    axis(ax);
    axis image; 
    axis off;
    setLabel(axis(), '(b) Canny', oft);
    
    subplot(1,4,3);
    subplot('position', [2*(w+ofx), ofy, w, h]);
    plot(P0(:,2), P0(:,1), 'k.', 'MarkerSize', 14);
    axis(ax);
    axis image; 
    axis off;
    set(gca, 'YDir', 'reverse');
    setLabel(axis(), '(c) point pattern', -22);
    
    subplot(1,4,4);
    subplot('position', [3*(w+ofx), ofy, w, h]);
    Et2 = Et(find(Et(:,3)),1:2);
    for i=1:size(Et2,1)
        p=Pt(Et2(i,1:2),:);
        plot(p(:,2), p(:,1), 'k-', 'LineWidth', 2);
        hold on;
    end
    axis(ax);
    axis image; 
    axis off;
    set(gca, 'YDir', 'reverse');
    setLabel(axis(), '(d) spanning tree', -22);
    
    colormap('gray');
    
function setLabel(a, str, offset)
    x = (a(1)+a(2))/2;
    y = a(4)-offset;
    text(x, y, str, 'HorizontalAlignment', 'center', 'FontSize', 14);
        
    
    