function tempX(X)
    clf;
    hold on;
    for i=1:size(X,1)-1
        plot(X([i i+1],2), X([i i+1],1), 'kx-', 'LineWidth', 2);
        if i==1
            set(gca, 'YDir', 'reverse');
            axis equal;
        end
    end
    ls={'rx-', 'gx-', 'bx-', 'mx-', 'cx-'};
    for i=1:size(X,1)-1
        plot(X([i i+1],2), X([i i+1],1), 'rx-', 'LineWidth', 2);
        if i==1
            set(gca, 'YDir', 'reverse');
            axis equal;
        end
        if i>100
            pause;
        end
        plot(X([i i+1],2), X([i i+1],1), 'gx-', 'LineWidth', 2);
    end

% function tempW(filespec, k, th)
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
%         [P F E] = DotOperations('triangulate', C, 1);
%         [P2 E2 F2 Sal] = TriangulationEdgeSaliency(P);
%         [P3 E3 F3 D3] = TriangulationCarving(P2, F2, Sal(:,3), 0.1); %1.0e-3);
%         [D dvals] = TriangulationDistanceMap(P3, F3(find(F3(:,4)),:), size(em));
%         [seeds] = TriangulationSegmentationSeeds(D, 10.0, .5);
%         [cycles starts] = TriangulationSegmentation(P, F, Sal(:,1), seeds, D);
%         
%         figure(4); clf;
%         tempDrawTriangles2(P3, F3(find(F3(:,4)),:));
% %         myimage(D); axis image;
%         figure(3); clf;
%         showContours(C, [], [], [], 'LineWidth', 2, 'Color', [1 0 0]);
%         figure(2); clf;
%         tempDrawEdges(P2, E2, Sal(:,2), 0, 'LineWidth', 2);
%         figure(1); clf;
%         tempDrawCycles(cycles, seeds, starts, P);
%         fprintf('hit ENTER\n');
%         pause;
%         clear C C0 em P F E P2 E2 F2 P3 E3 F3 D dvals U W seeds Sal D3 cycles starts;
%     end

%     for i=3:length(files)
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
%         [P F E fit] = TriangulationEdgeRelaxation(C, K, 0, 3*K);
% %         [P2 E2] = TriangulationClustering(P, E, fit, median(fit));   
%         [P2 F2 E2] = TriangulationCarving(P, F, E, fit);
%         figure(1);
%         clf;
% %         showPoints(P2, [], P2(:,3));
%         tempDrawTriangles2(P, F);
%         tempDrawEdges(P2, E2, E2(:,3), 0, 'LineWidth', 2);
%         fprintf('hit ENTER\n');
%         pause;
%         clear C C0 em P F E P2 E2 fit;
%     end
% 

% function k = tempX(P, E, fitness)
% %select two most fit edges per point
%     n = size(P,1);
%     S=zeros(2*n,1);
%     for i=1:n
%         j=find(E(:,1)==i | E(:,2)==i);
%         vals = fitness(j);
%         [svals si] = sort(vals, 'descend');
%         k = j(si([1 2]));
%         S(2*i-1:2*i)=k;
%     end
%     k = unique(S);

% function tempX(filespec, m, k)
%     files = dir(filespec);
%     pathstr = fileparts(filespec);
%     for i=1:length(files)
%         fprintf('%s: %d out of %d.\n', files(i).name, i, length(files));
%         load([pathstr '\' files(i).name]);
%         C0 = ContourPrep(em); C=ContourBreak(C0);
%         [P F E] = TriangulationEdgeRelaxation(C, 1, 0, 3);
%         [P2 E2] = TriangulationEdgeCut(P, E, [], 10);      
%         figure(1);
%         clf;
%         subplot(1,2,1);
%         j=find(E(:,4));
%         j2=find(E(:,4) & E(:,5)>.5);
%         tempDrawEdges(P, E(j,:), [], 0, 'LineWidth', 2, 'Color', [0 0 1]);
%         tempDrawEdges(P, E(j2,:), [], 0, 'LineWidth', 2, 'Color', [1 0 0]); 
%         subplot(1,2,2);
%         showPoints(P2, [], P2(:,3));
%         pause;
%         clear C0 C P F E P2 E2 em j j2;
%     end
   
%     if ~exist('k','var') | isempty(k)
%         k = 2;
%     end
%     if ~exist('m','var') | isempty(m)
%         m = 3;
%     end
%     files = dir(filespec);
%     pathstr = fileparts(filespec);
%     for i=1:length(files)
%         fprintf('%s: %d out of %d.\n', files(i).name, i, length(files));
%         [J P E] = mstSpectralClustering([pathstr '\' files(i).name], m, k);
%         figure(1);
%         clf;
%         showPoints(P, [], J, 'LineWidth', 2, 'MarkerSize', 8);
%     end
   