function runSelectedShapes()
%run grouping and evaluation on shape+noise data set
    
    folder = '.\Mat\';
    files = dir([folder '*.mat']);    
    for i=1:length(files)
        filename = [folder files(i).name];
        fprintf('%d: %s\n', i, filename);
        t = load (filename);
        P0 = t.P0;
        clear t;

        [Pt Ft Et] = TriangulationTree(P0);
        [X Y Z W V U] = StraightMedialAxisSmoothing(Pt,Et(find(Et(:,3)),1:2),50);
        [high id outline] = tempShowGroupResultV2(P0, U);
        save(filename, 'P0', 'Pt', 'Ft', 'Et', ...
            'X', 'Y', 'Z', 'W', 'V', 'U', 'high', 'id', 'outline');
    end
    