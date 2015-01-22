function result = groupingAnalysis(X, Y, names)
%derive descriptive stats of two samples (X andn Y).
%Each row of X and Y corresponds to responses on each shape.
%Each column of X and Y correspnds to responses of each participant.
%X and Y are from different representations (Points, Triangles,
%AllTriangles).
%NAMES is a cell array with the names of the shapes.

    for i=1:size(X,1)
        [h p ci] = ttest2(X(i,:), Y(i,:), 0.05, 'both');
        m1 = mean(X(i,:));
        m2 = mean(Y(i,:));
        s1 = std(X(i,:));
        s2 = std(Y(i,:));
        mp = mean([X(i,:) Y(i,:)]);
        sp = std([X(i,:) Y(i,:)]);
        d = abs(m1-m2)/sp;
        result(i,:)=[p ci d m1 m2 s1 s2 mp sp];
    end
    
    if ~isempty(names)
        fprintf('shape\tp\tci\t\td\tm1\tm2\ts1\ts2\tmp\tsp\n');
        for i=1:length(names)
            fprintf('%s\t', names{i});
            fprintf('%0.3f\t', result(i,:));
            fprintf('\n');
        end
    end
    
    