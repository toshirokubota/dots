function P = contours2points(C, skip, minlen)
%Take a cell array of contours, 

    if ~exist('skip','var') | isempty(skip)
        skip = 1;
    end
    if ~exist('minlen','var') | isempty(minlen)
        minlen = 1;
    end
    P = [];
    for i=1:length(C)
        pnts = C{i};
        pnts = pnts(1:skip:end,:);
        if size(pnts,1)>=minlen
            P(end+1:end+size(pnts,1), 1:2) = pnts(:,1:2);
        end
    end
    
    %remove duplicates
    dims = max(P);
    X = P(:,1) * ceil(dims(1)) + P(:,2);
    [Y I J] = unique(X);
    P = P(I,:);
