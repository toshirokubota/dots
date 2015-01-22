function results = dotGroupingBatch(filespec)
    pathstr = fileparts(filespec);
    files = dir(filespec);
    results=[];
    for i=1:length(files)
        fprintf('%s (%d out of %d)\n', files(i).name, i, length(files));
        try
            t = load([pathstr '\' files(i).name]);
        catch
            continue;
        end
        [em2 P0] = randomSubsample(t.em, 5);
        [Res info U Se P2 E2 F5 S D D2] = dotGrouping(P0);
%         figure(1); 
%         clf;
%         tempDrawEdges(P, E2, E2(:,3), [], '', 'LineWidth', 2);
%         figure(2); 
%         clf;
%         tempDrawEdges(P, E2, E2(:,3)>quantile(E2(:,3), 0.9), [], '', 'LineWidth', 2); 
%         figure(3);
%         clf;
%         tempDrawColoredTriangles(P, F, D, [], colormap('jet'));
%         figure(4);
%         clf;
%         tempDrawColoredTriangles(P, F, F(:,4), [], colormap('jet'));
%         figure(5);
%         clf;
%         showPoints(P, [], [], '.', 'MarkerSize', 14)
%         
        pause;
    end
        