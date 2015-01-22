function showThem(filespec)
    if ~exist('folder','var') | isempty(filespec)
        filespec = '.\\*.mat';
    end
    folder = fileparts(filespec);
    files = dir(filespec);
    for i=1:length(files)
        fprintf('%s - %d out of (%d)\n', files(i).name, i, length(files));
        filename = [folder files(i).name];
        t = load(filename);
        clf;
        plot(t.Pt(:,2), t.Pt(:,1), 'k.', 'MarkerSize', 14);
        hold on;
        plot(t.outline([1:end 1],2), t.outline([1:end 1],1), 'r-', 'LineWidth', 2);
        axis image;
        set(gca, 'YDir', 'reverse');
        axis off;
        title(sprintf('%s %f', filename, t.high));
        
        pause;
    end
    
    