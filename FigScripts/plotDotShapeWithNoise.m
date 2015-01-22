function plotDotShapeWithNNoise(name)
% make four plots with a shape with various noise level.
%it reads three files: name.shape_0_dots.txt, name.shape_1_dots.txt, and 
%name.shape_0_dots.txt where 'name' is the parameter being passed to this
%script. Files will be searched in ..\shapeWithDots.

    folder = '..\shapeWithNoise\';
    
    clf;
    resizeFigure(gcf, [], [1 4], [250 250]);
    w = 0.23;
    h = 0.96;
    ofx = 0.02;
    ofy = 0.02;
    for i=1:3
        pnts = dlmread([folder name '.shape_' num2str(3-i) '_dots.txt']);
        if i==1
            shape = pnts(find(pnts(:,3)~=1),:);
            subplot(1,4,1);
            subplot('position', [0 ofy w h]);
            plot(shape(:,2), shape(:,1), 'k.', 'MarkerSize', 12);
            axis equal;
            axis off;
            set(gca, 'YDir', 'reverse');
            title('shape');
        end
        subplot(1,4,i+1);
        subplot('position', [(w+ofx)*i ofy w h]);
        plot(pnts(:,2), pnts(:,1), 'k.', 'MarkerSize', 12);
        axis equal;
        axis off;
        set(gca, 'YDir', 'reverse');
    end
    
            
    