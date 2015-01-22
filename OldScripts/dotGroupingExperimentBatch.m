function results = dotGroupingExperimentBatch(filespec)
    pathstr = fileparts(filespec);
    files = dir(filespec);
    results=[];
    for i=1:length(files)
        fprintf('%s (%d out of %d)\n', files(i).name, i, length(files));
        try
            C = shape2contour([pathstr '\' files(i).name]);
        catch
            continue;
        end
        res.filename = files(i).name;
        res.nump=[];
        res.numFaces=[];
        res.numDetected=[];
        res.diff1=[];
        res.diff2=[];
        for nump=100 %20:10:200
            [P F E S R] = TriangulationCurving(C, nump);
            df1 = setdiff(F, R, 'rows');
            df2 = setdiff(R, F, 'rows');
            fprintf('card(F)=%d, card(R)=%d, diff = (%d,%d) (%3.3f,%3.3f)\n',...
                size(F,1), size(R,1), size(df1,1), size(df2,1),...
                size(df1,1)/size(F,1), size(df2,1)/size(R,1));
            res.nump(end+1)=nump;
            res.numFaces(end+1) = size(R,1);
            res.numDetected(end+1) = size(F,1);
            res.diff1(end+1) = size(df1,1)/size(F,1);
            res.diff2(end+1) = size(df2,1)/size(R,1);            
        end
        if isempty(results)
            results = res;
        else
            results(end+1)=res;
        end
        figure(1); clf;
        tempDrawTrianglePatches(P, F, []);  
        S(end+1,:)=S(1,:);
        showContours({S}, [], [], [], 'LineWidth', 2, 'Color', [1 0 0]);
        figure(2); clf;
        tempDrawTrianglePatches(P, R, []);  
        P(end+1,:)=P(1,:);
        showContours({P}, [], [], [], 'LineWidth', 2, 'Color', [0 1 0]);
        figure(3); clf;
        tempDrawPoints(P);
        pause;
    end
    
    for i=1:length(results)
        fprintf('%s\n', results(i).filename);
        fprintf('%d\t', results(i).numFaces); fprintf('\n');
        fprintf('%d\t', results(i).numDetected); fprintf('\n');
        fprintf('%3.3f\t', results(i).diff1); fprintf('\n');
        fprintf('%3.3f\t', results(i).diff2); fprintf('\n');
    end
    
    
        