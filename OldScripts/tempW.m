function tempW(filespec, k, th)
%     if ~exist('k','var') | isempty(k)
%         K = 1;
%     end
%     if ~exist('th','var') | isempty(th)
%         th = 100;
%     end
    files = dir(filespec);
    pathstr = fileparts(filespec);
    for i=165:length(files)
        fprintf('%s: %d out of %d.\n', files(i).name, i, length(files));
        try
            load([pathstr '\' files(i).name]);
        catch
            fprintf('Failed to load %f. Continue...\n', files(i).name);
            continue;
        end
        [em2 P0] = randomSubsample(em, 5);
        [Pt Ft Et] = TriangulationTree(P0);
        [X Y Z W V] = StraightMedialAxisSmoothing(Pt, Et(find(Et(:,3)),1:2), 20, [], 0.1);  
        figure(1);
        clf;
        showPoints(P0, [], [], 'r.', 'MarkerSize', 14);
        axis([0 size(em2,2) 0 size(em2,1)])
%         figure(3);
%         tempPlotStraightMedialAxis(P0, X, Z, []);
%         axis([0 size(em2,2) 0 size(em2,1)])
        figure(2);
        clf;
        tempPlotStraightMedialAxis(Pt, X, Z, W, W, em2);
%         axis([0 size(em2,2) 0 size(em2,1)]);
        fprintf('hit ENTER.\n');
        pause;
        clear em2 P0 Pt Ft Et X Y Z W;
    end
    
%     if ~exist('k','var') | isempty(k)
%         K = 1;
%     end
%     if ~exist('th','var') | isempty(th)
%         th = 100;
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
%         C0 = ContourPrep(em);
%         C=ContourBreak(C0);
%         [P F E] = TriangulationEdgeRelaxation(C, K, 0, K*3);
%         [P2 E2] = TriangulationEdgeCut(P, E);
%         
%         figure(1);
%         clf;
%         tempDrawTriangles2(P, F, [], [], 'LineWidth', 1, 'Color', [0 1 1]);
%         tempDrawEdges(P, E2, [], 0, 'LineWidth', 2, 'Color', [1 0 0]);
%         th=quantile(E2(find(E2(:,3)),3), [0.5 0.75]);
%         id=find(E2(:,3)>th(1) & E2(:,3)<=th(2));
%         tempDrawEdges(P, E2(id,:), [], 0, 'LineWidth', 4, 'Color', [0 0 1]);
%         id=find(E2(:,3)>th(2));
%         tempDrawEdges(P, E2(id,:), [], 0, 'LineWidth', 4, 'Color', [0 1 0]);
%         [ev ej] = sort(E2(:,3), 'descend');
%         j=1;
%         while(true)
%             if j>10 %ev(j)<th
%                 break;
%             end
%             k=ej(j); %edge to remove
%             E2b=E2;
%             E2b(k,:)=[]; %remove it
%             [P3 E3] = DotOperations('cluster', P2, E2b);
%             figure(2);
%             clf;
%             hold on;
%             id = find(E3(:,3)==0);
%             tempDrawEdges(P, E3(id,:), [], 0, 'LineWidth', 2, 'Color', [0 1 0]);
%             id = find(E3(:,3)==1);
%             tempDrawEdges(P, E3(id,:), [], 0, 'LineWidth', 2, 'Color', [0 0 1]);
%             tempDrawEdges(P, E2(k,:), [], 0, 'LineWidth', 2, 'Color', [1 0 0]);       
%             fprintf('hit ENTER\n');
%             pause;
%             j = j + 1;
%         end
%         clear C C0 em P F E;
%     end
    
%     if ~exist('K','var') | isempty(K)
%         K = 20;
%     end
%     files = dir(filespec);
%     pathstr = fileparts(filespec);
%     for i=1:length(files)
%         fprintf('%s: %d out of %d.\n', files(i).name, i, length(files));
%         try 
%             Q = shape2points([pathstr '\' files(i).name]);
%         catch
%             fprintf('Failed to read %f. Continue...\n', files(i).name);
%             continue;
%         end
%         Q(:,7)=0; 
%         C{1}=single(Q);
%         [P F E S R O R2] = TriangulationCarving(C, K, inf);
%         [P F E] = DotOperations('triangulate', C, K);
%         dmap = TriangulationDistanceMap(S, max(Q(:,1:2))+1);
%         [W Q Q2 Q3 P2 E2] = TriangulationEdgeRelaxation(P, F, dmap, 100, 50);
%         clf;
%         W(find(W(:,3)>1),3)=1;
%         W(find(W(:,3)<0),3)=0;
%         j = find(W(:,3)>.0);
%         tempDrawEdges(P2, E2, W(:,3), 1, 'LineWidth', 2);
%         input('hit return to continue.');
%         clear Q Q2 Q3 P2 E2 P F S C dmap R O R2;
%     end
% 

% function tempW(dmap, C, maxIter)
%     if ~exist('maxIter','var') | isempty(maxIter)
%         maxIter = 100;
%     end
%     
%     C2 = C;
%     for i=1:maxIter
%         myimage(dmap);
%         showContours(C, [], [], [], 'o', 'LineWidth', 2, 'Color', [0 0 0]);
% %         [C2 labels C3 C4] = ContourMigration(C, dmap, i, 1);
%         [C2] = ContourMigration(C2, dmap, 1, 1);
%         showContours(C2, [], [], [], 'o', 'LineWidth', 2, 'Color', [1 1 1]);
%         title(sprintf('%d', i));
%         pause;
%     end
%     
%     