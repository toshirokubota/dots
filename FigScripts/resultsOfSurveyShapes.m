function resultsOfSurveyShapes()
%read result (MAT) files for shape instances used in our survey
%and print out the area overlap measure.
%
    filenames = {'arrow2', 'camel1', 'palmtree0', 'pistol2', ...
        'anchor0', 'balloon2', 'cherries1', 'star1', 'car2', ...
        'dolphin0', 'fish1', 'umbrella1', 'duck2', 'horse1',...
        'shoe2', 'violin0'};
    folder = '.\Mat\';
    for i=1:length(filenames)
        t = load([folder filenames{i}]);
        fprintf('%s\t%3.3f\n', filenames{i}, t.high);
    end
    