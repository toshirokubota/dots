function tempV(filespec, k, th)
%     if ~exist('k','var') | isempty(k)
%         K = 1;
%     end
%     if ~exist('th','var') | isempty(th)
%         th = 100;
%     end
    files = dir(filespec);
    pathstr = fileparts(filespec);
    for i=1:length(files)
        fprintf('%s: %d out of %d.\n', files(i).name, i, length(files));
        try
            [C0 P0] = shape2contour([pathstr '\' files(i).name], 20);
        catch
            fprintf('Failed to load %f. Continue...\n', files(i).name);
            continue;
        end
        [Pt Ft Et] = TriangulationTree(P0);
        [X Y Z W] = StraightMedialAxis(Pt, Et(find(Et(:,3)),1:2), [100], 2000);  
        box = max(P0(:,1:2));
        figure(1);
        showPoints(P0, [], [], 'rx', 'MarkerSize', 14);
        a = axis;
        figure(2);
        tempPlotStraightMedialAxis(P0, X, Z, []);
        axis([a(1)-20 a(2)+20 a(3)-20 a(4)+20])
        figure(3);
        tempPlotStraightMedialAxis(P0, X, Z, W);
        axis([a(1)-20 a(2)+20 a(3)-20 a(4)+20])
        pause;
        clear C0 P0 Pt Ft Et X Y Z W;
    end
    
% function tempV(filespec, K)
%     if ~exist('K','var') | isempty(K)
%         K = 5;
%     end
%     files = dir(filespec);
%     pathstr = fileparts(filespec);
%     for i=1:length(files)
%         fprintf('%s: %d out of %d.\n', files(i).name, i, length(files));
%         try 
%             load([pathstr '\' files(i).name]);
%         catch
%             fprintf('Failed to load %f. Continue...\n', files(i).name);
%             continue;
%         end
% 
%         C = ContourPrep(em);
%         [P F E S R O R2] = TriangulationCarving(C, 5, 5);
%         dmap = TriangulationDistanceMap(S, size(em));
% %         fg = dmap>0;
% %         [V M G H] = DotOperations('medaxis', fg, 10);
% %         L = ContourPrep(M);
% %         X = ContourClustering(C, L, dmap);
%         [C2 labels C3 C4] = ContourMigration(C, dmap, 100, 1);
%         X = ContourClustering(C2);
%         [cids ctrs] = kmeans(X, K);
%         clf;
% %         subplot(1,2,1);
%         showClusteredContours(C, cids);
% %         subplot(1,2,2);
% %         showContours(C, [], [], [], 'LineWidth', 2, 'Color', [1 0 0]);
% %         showContours(L, [], [], [], 'LineWidth', 2, 'Color', [0 0 1]);
% %         hold on;
% %         plot(V(:,2)+1, V(:,1)+1, 'o', 'LineWidth', 2, 'Color', [1 0 0]);
% % %         tempDrawEdges(V, M, [], [], 'LineWidth', 2, 'Color', [0 0 1]);        
%         
%         input('hit return to continue.');
%         clear im em P F S C dmap M V G H fg R O R2;
%     end
% % 
%     for i=1:length(files)
%         fprintf('%s: %d out of %d.\n', files(i).name, i, length(files));
%         try 
%             load([pathstr '\' files(i).name]);
%         catch
%             fprintf('Failed to load %f. Continue...\n', files(i).name);
%             continue;
%         end
%         
%         [P F S dmap lmap tmap labels seeds C] = tempSegmentationFromTriangulation(em);
%         [C2 W] = ContourMigration(C, dmap, 100);
%         cl = clusterContours(W, 10);
%         figure(1); clf;
%         myimage(im);
%         figure(2); clf;
%         myimage(dmap);
%         showContours(C, [], [], [], '-', 'LineWidth', 2, 'Color', [0 0 0]);
%         figure(3); clf;
%         showClusteredContours(C, cl);
%         hold on;
%         plot(S(:,2), S(:,1), '-', 'Color', [0 0 0], 'LineWidth', 2);
%         hold off;
%         
%         pause;
%         clear im em P F S dmap lmap tmap labels seeds C C2 W cl;
%     end
% 

% function tempV(C, dmap)
% 
%     clf;
%     myimage(dmap);
%     showContours(C, [], [], [], '-', 'LineWidth', 2, 'Color', [1 1 1]);
%     pause;
%     for i=1:100
%         C = ContourMigration(C, dmap, 1);
%         clf;
%         myimage(dmap);
%         showContours(C, [], [], [], '-', 'LineWidth', 2, 'Color', [1 1 1]);
%         pause;
%     end
% 

% foveaAngle = 5; % in degrees
% displaySize = 0.875*2.54; % in cm
% retinaAngle = 30; %in degrees
% distanceFovea = displaySize/tan(foveaAngle*pi/360);
% distanceRetina = displaySize/tan(retinaAngle*pi/360);
% fprintf('seating for the foveal projection: %2.2f cm or %2.2f inches\n',...
%     distanceFovea, distanceFovea/2.54);
% fprintf('seating for the peripheral projection: %2.2f cm or %2.2f inches\n',...
%     distanceRetina, distanceRetina/2.54);
% 
