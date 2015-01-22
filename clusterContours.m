function cl = clusterContours(W, thres)
%find connected components from an adjacent matrix (W) of an undirected
%graph. 
    W(find(W>thres))=inf;
    W(find(W<=thres))=0;
    d = squareform(W);
    lk = linkage(d);
    cl = cluster(lk, 'Cutoff', 5, 'Criterion', 'distance');
    
%OLD STUFF...
%     if mode <= 3 & mode>=1
%         m = max(W(find(W<inf)));
%         W(find(W==inf))=m+1;
%         
%         W = 1 - W/max(W(:));
%         cl0 = SpectralClustering(double(W), K, mode);
%         cl0 = full(cl0);
%         for i=1:size(cl0,1)
%             cl(i) = find(cl0(i,:));
%         end
%     elseif mode==4
%         thres = quantile(W(:), perc);
%         [cl lk] = HierarchicalCluster(W, thres, K);
%     end
%     
% function [cl lk d] = HierarchicalCluster(W, thres, k)
%     %set zero in off diagonal to inf.
% %     W(W==0) = inf;
% %     for i=1:size(W,1)
% %         W(i,i)=0;
% %     end
%     
%     d = squareform(W);
% %     lk = linkage(d);
% %     lk = linkage(d, 'ward');
%     lk = linkage(d, 'complete');
% %     cl = cluster(lk, 'Cutoff', 1.5);
% %     k = length(find(lk(:,3)>thres));
% %     cl = cluster(lk, k);
%     cl = cluster(lk, 'Cutoff', 5, 'Criterion', 'distance');
%     
% function V = kNearestNeighbors(W, K)
%     V = zeros(size(W));
%     for i=1:size(W)
%         [sv j] = sort(W(i,:), 2, 'descend');
%         V(i,j(1:K)) = sv(1:K);
%     end
%     V = (V + V')/2;
        
        
        