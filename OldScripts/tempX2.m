function tempW(filespec, k, th)
    if ~exist('k','var') | isempty(k)
        K = 1;
    end
    if ~exist('th','var') | isempty(th)
        th = 100;
    end
    files = dir(filespec);
    pathstr = fileparts(filespec);
    for i=1:length(files)
        fprintf('%s: %d out of %d.\n', files(i).name, i, length(files));
        try
            load([pathstr '\' files(i).name]);
        catch
            fprintf('Failed to load %f. Continue...\n', files(i).name);
            continue;
        end
            
        C0 = ContourPrep(em);
        C=ContourBreak(C0);
        [P F E fit sup] = TriangulationEdgeRelaxation(C, 1, 0, 10);
        [P2 E2 F2] = Testbed(P, 0.9);
        [P3 E3 F3 D3] = TriangulationCarving(P, F, E, fit, E2(:,4));
        figure(1);
        clf;
        tempDrawEdges(P, E2, E2(:,4), 0, 'LineWidth', 2);
%         showPoints(P2, [], P2(:,3));
%         tempDrawTriangles2(P, F);
%         tempDrawEdges(P2, E2, E2(:,3), 0, 'LineWidth', 2);
        figure(2);
        clf;
        tempDrawEdges(P3, E3);
%         tempDrawEdges(P2, E2, [], 0, 'LineWidth', 2);
        fprintf('hit ENTER\n');
        pause;
        clear C C0 em P F E P2 E2 F2 P3 E3 F3 D3 fit sup ;
    end


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
   