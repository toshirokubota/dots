function [K B] = tempY(P0, K, B)
    if ~exist('K', 'var') || ~exist('B', 'var')
        [K B] = RosenbergLangridge(P0);
    end
    J=B;
    figure(1); clf;
    showPoints(P0, [], [], 'k.', 'MarkerSize', 14);
    hold on;
%     for i=1:size(P0,1)
%         p=double(P0(i,:));
%         text(p(2), p(1), num2str(i));
%     end
    for i=1:size(J,1)
        p=P0(J(i,1),:);
        q=P0(J(i,2),:);
        plot([p(2) q(2)], [p(1) q(1)], 'r-', 'LineWidth', 2);
    end
    J=K;
    figure(2); clf;
    showPoints(P0, [], [], 'k.', 'MarkerSize', 14);
    hold on;
%     for i=1:size(P0,1)
%         p=double(P0(i,:));
%         text(p(2), p(1), num2str(i));
%     end
    for i=1:size(J,1)
        p=P0(J(i,1),:);
        q=P0(J(i,2),:);
        plot([p(2) q(2)], [p(1) q(1)], 'r-', 'LineWidth', 2);
    end

% function tempY(filespec, k, m)
%     k = 1;
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
%         [P F E] = TriangulationEdgeRelaxation(C, k, 0, k*3);
% %         [P2 F2 E2] = TriangulationClustering(P, M);    
% %         [sv si] = sort(M(:,5), 'descend');
%         tree = E(find(E(:,4)),:);
%         [fit si] = sort(tree(:,5), 1, 'descend');
%         for n=1:5
%             id = si(n);
%             [P2 E2 F2 tree2 measure] = Testbed(P, F, tree, id);
%             figure(n);
%             tempDrawColoredTriangles(P2, F2, F2(:,4));
%             title(sprintf('%d, %f, %f', id, fit(n), measure));
%         end
%         clear C C0 em P F E;
%     end
    
%     if ~exist('k','var') | isempty(k)
%         k = 2;
%     end
%     if ~exist('m','var') | isempty(m)
%         m = 3;
%     end
%     files = dir(filespec);
%     pathstr = fileparts(filespec);
%     del = 0.01;
%     Nf=[2 2];
%     w = (1.0-del)/Nf(1)-del;
%     h = (1.0-del)/Nf(2)-del;
%     margin=2;
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
%         [P F E] = TriangulationEdgeRelaxation(C, k, 0, k*3);
% %         [P2 F2 E2] = TriangulationClustering(P, M);    
% %         [sv si] = sort(M(:,5), 'descend');
%         
%         clf;
%         resizeFigure(gcf, [], 2*size(im)+3*margin, [2 2]);
%         subplot(Nf(1), Nf(2),1);
%         subplot('Position', [del 2*del+h w h]);
%         imagesc(im); %colormap('gray');
%         ax = axis(); axis equal; axis off;
%         subplot(Nf(1), Nf(2),2);
%         subplot('Position', [2*del+w 2*del+h w h]);
%         imagesc(~em); %colormap('gray'); 
%         axis equal; axis off;
%         j=find(E(:,5));
%         subplot(Nf(1), Nf(2),3);
%         subplot('Position', [del del w h]);
%         tempDrawEdges(P, E(j,:), [], 0, 'LineWidth', 2);
%         hold on;
%         j2=find(P(:,3)>2);
%         j1=find(P(:,3)==1);
%         plot(P(j2,2), P(j2,1), 'ro', 'LineWidth', 2);
%         plot(P(j1,2), P(j1,1), 'gx', 'LineWidth', 2);
%         axis(ax); axis equal; axis off;
% 
%         subplot(Nf(1), Nf(2),4);
%         subplot('Position', [2*del+w del w h]);
%         showPoints(P, [], P(:,4));
%         axis(ax); axis equal; axis off; colormap('jet');
% %         tempDrawEdges(P, M(si(1:m),:), [], 0, 'LineWidth', 3, 'Color', [1 0 0]);
%         hold off;
%         pause;
%         clear C C0 em P F E;
%     end
