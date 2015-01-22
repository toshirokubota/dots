function [Res info U Se P2 E2 F2 F5 S D D2 I L] = dotGrouping(P0)
%a new dot-grouping algorithm [12/31/2013]

    perc = 0.95;
    salThres = 0.;
    maxSeeds = 32;
    numStops = 1;
    
%     [em2 P0] = randomSubsample(em, s);
    [P F E] = DotOperations('delaunay', P0);
%     [P2 F2 E2 S T X] = TriangulationEdgeSaliency(P, 10, 0., 0, 0.95, 0, 100);
    [P2 F2 E2 S T X] = TriangulationEdgeSaliency(P, 10, 0., 0, 0.75, 0, 100);
    
%     thres = quantile(E2(:,3),0.9);
    [P5 E5 F5 D D2 I L] = TriangulationSegmentationSeeds(P2, F2, E2(:,3)>0, 3, 10);
    
%     figure(1); clf;
%     tempDrawEdges(P2, E2, E2(:,3), [], '', 'LineWidth', 2);
%     figure(2); clf;
%     tempDrawEdges(P2, E2, E2(:,3)>0, [], '', 'LineWidth', 2);
%     figure(3); clf;
%     tempDrawColoredTriangles(P, F, D, [], colormap('jet'));
%     figure(4); clf;
%     tempDrawColoredTriangles(P, F, F5(:,4), [], colormap('jet'));
%     pause;
    
    starts = find(F5(:,4)); %selectStartPositions(F5(:,4), D, maxSeeds);
    fprintf('starts: '); fprintf('%d ', starts'); fprintf('\n');
    Res=[];
    info=[];
    figure(3); clf;
    for start = starts'
%         [P4 E4 F4 O N] = TriangulationSegmentation(P2, F2, (E2(:,5)), start, [size(F,1)-50], [1 10 10 10 .0], [0.0 0.0 15 15]);
        [P4 E4 F4 O N] = TriangulationSegmentation(P2, F2, (E2(:,5)), start, [size(F,1)-50], [5 20 10 10 .0], [0.0 0.0 15 15]);
        stops = find(N(:,3));
        fprintf('stops: '); fprintf('%d ', stops'); fprintf('\n');
        figure(3);  plot(N(1:end,4)); hold on; plot(stops, N(stops,4), 'ro');
        for stop = stops'
            j = O(1:stop);
            if isempty(Res)
                Res=zeros(size(F,1),1);
                Res(j,1) = 1;
                info = [start stop];
            else
                Res(j,end+1)=1;
                info(end+1,:) = [start stop];
            end
        end
    end
    U = uniquefy(Res);
    Se = Testbed(P, F, Res);
    figure(1); clf;
%     tempDrawColoredTriangles(P, F5, F5(:,4), [], colormap('jet'));
    tempDrawTriangles2(P, F);
    hold on; tempDrawTriangles2(P, F, 1, starts);
    figure(2); clf;
    tempDrawEdges(P2, E2, Se, [], '', 'LineWidth', 2);
    figure(4); clf;
    thres = quantile(E2(:,5), .7);
    tempDrawEdges(P2, E2, Se>0 & E2(:,5)>thres, [], '', 'LineWidth', 2);
    h = figure(5);
    clf;
    for i = 1:size(Res,2)
        figure(h);
        tempDrawColoredTriangles(P, F, Res(:,i), [], colormap('jet'));
        pause;
    end

function U = uniquefy(A)
    vals = unique(A, 'rows');
    U = zeros(size(A,1),1);
    for i=1:size(vals,1)
        U(ismember(A, vals(i,:), 'rows')) = i;
    end
    
