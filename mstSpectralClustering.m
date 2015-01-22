function [J P E] = mstSpectralClustering(filename, nClusters, k)
%Get a minimum spanning tree representation of a triangulation graph and
%apply the normalized cut to cluster the tree.

    if ~exist('nClusters','var') | isempty(nClusters)
        nClusters = 2;
    end
    if ~exist('k','var') | isempty(k)
        k = 2;
    end
    
    load (filename);
    C0 = ContourPrep(em); C=ContourBreak(C0);
    [P F E] = TriangulationEdgeRelaxation(C, k, 0, 3*k);
    P=double(P); E=double(E);
    %draw spanning tree
    j=find(E(:,4));
%     figure(1);
%     clf;
%     tempDrawEdges(P, E(j,:), [], 0, 'LineWidth', 2);
%     hold on;
%     j2=find(P(:,3)>2);
%     j1=find(P(:,3)==1);
%     plot(P(j2,2), P(j2,1), 'ro', 'LineWidth', 2);
%     plot(P(j1,2), P(j1,1), 'gx', 'LineWidth', 2);
%     axis equal; axis off;
    
    %build a affinity matrix
    n = size(P,1);
%     A = zeros(n, n);
%     for i=j'
%         A(E(i,1), E(i,2))=1.0/E(i,5);
%         A(E(i,2), E(i,1))=1.0/E(i,5);
%     end
    A = sparse([E(j,1);E(j,2)], [E(j,2);E(j,1)], 1.0./[E(j,5); E(j,5)], n, n);
%     A = sparse([E(j,1)], [E(j,2)], 1.0./[E(j,5)], n, n);
    
    S = SpectralClustering(A, nClusters, 3);
    [vals J] = max(S, [], 2);
%     figure(2);
%     clf;
%     showPoints(P, [], J, 'LineWidth', 2, 'MarkerSize', 8);
    
    
    