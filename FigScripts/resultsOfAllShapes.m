function resultsOfAllShapes()
%read result (MAT) files for all shapes and all noise levels
%and print out the area overlap measure.
%
    shapenames = {'anchor', 'arrow', 'balloon', 'camel', 'car', ...
        'cherries', 'dolphin', 'duck', 'fish', 'horse', 'kangaroo',... 
        'palmtree', 'pistol', 'plane', 'shoe', 'squirrel', 'star',... 
        'telephone', 'umbrella', 'violin'};
    levels = {'Clean', '2', '1', '0'};
    folder = '.\Mat\';
    for i=1:length(shapenames)
        fprintf('%s\t', shapenames{i});
        for j=1:length(levels)
            t = load([folder shapenames{i} levels{j}]);
            fprintf('%3.3f\t', t.high);
        end
        fprintf('\n');
    end
    