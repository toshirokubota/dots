function [scores outlines filenames] = testShapePerceivabilityBatch(folder)

    files = dir(folder);
    display = 1;
    scores=[];
    outlines={};
    filenames={};
    for i=1:length(files)
        try
            P0 = dlmread([folder '\' files(i).name]);
        catch
            continue;
        end
        fprintf('%s (%d out of %d)\n', files(i).name, i, length(files));
        [score outline] = testShapePerceivability(P0(:,1:2), P0(:,3));
        scores(end+1) = score;
        outlines{end+1}= outline;
        filenames{end+1} = files(i).name;
        
        if display
            shape = P0(find(P0(:,3)==0),:);
            figure(1);
            hold off;
            showPoints(P0, [], [], '.', 'MarkerSize', 14);
            figure(2);
            hold off;
            showPoints(P0, [], [], '.', 'MarkerSize', 14);
            hold on;
            plot(shape([1:length(shape) 1],2), shape([1:length(shape) 1],1),...
            'g-', 'LineWidth', 2);
            plot(outline([1:length(outline) 1],2), outline([1:length(outline) 1],1),...
            'r-', 'LineWidth', 2);
            hold off;
            title(sprintf('%s, %f', files(i).name, score));
            pause;
        end
    end
    
            
