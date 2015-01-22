function checkFixed()
    addpath('C:\Users\Kubota\Documents\MATLAB\Dots\');
    files = dir('fixed\\*.mat');
    for i=1:length(files)
        load(['fixed\\' files(i).name]);
        showPoints(P, P(:,3), 10*(P(:,3)+1), 'MarkerSize', 14);
        title(files(i).name);
        pause;
        clf;
    end