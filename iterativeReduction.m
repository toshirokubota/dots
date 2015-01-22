function P2 = iterativeReduction(P, cutoff, thres, perc, niter)
    if ~exist('cutoff', 'var') | isempty(cutoff)
        cutoff = 1;
    end
    if ~exist('thres', 'var') | isempty(thres)
        thres = 0;
    end
    if ~exist('perc', 'var') | isempty(perc)
        perc = 0.75;
    end
    if ~exist('niter', 'var') | isempty(niter)
        niter = inf;
    end
    i=0;
    [P F E] = DotOperations('delaunay', P);
    elen = edgeLength(P, E);
    lthres = quantile(elen, perc);
    while(i < inf)
        i = i + 1;
        [P2 F2 E2 S T X] = TriangulationEdgeSaliency(P, 10, thres, lthres);
        figure(1);
        showPoints(P2, [], S(:,4), 'MarkerSize', 14);

        j=find(S(:,4)<=cutoff);
        if isempty(j)
            break;
        end
        
        figure(2);
        showPoints(P2, [], S(:,4)<=cutoff, 'MarkerSize', 14);
        pause;
        j = find(S(:,4)>cutoff);
        P = P2(j,1:2);
    end
    
function L = edgeLength(P, E)
    p=P(E(:,1),:);
    q=P(E(:,2),:);
    L = sqrt(sum((p-q).*(p-q), 2));
    
    