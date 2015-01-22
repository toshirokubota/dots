function showClusteredContoursInteractive(C, labels)
    
    for label=unique(labels')
        j=find(labels'==label);
        clf;
        showContours(C, [], [], [], 'LineWidth', 2, 'Color', [0 0 1]);
        showContours(C, [j], [], [], 'LineWidth', 2, 'Color', [1 0 0]);
        pause;
    end
    
    