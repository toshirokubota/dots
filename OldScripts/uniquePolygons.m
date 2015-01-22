function U = uniquePolygons(G, sz)
%This script remove duplicate polygons from G and returns the unique set.
%SZ is used to facilitate comparison by converting pixel coordinates into
%subscripts.

    if ~exist('sz','var') | isempty(sz)
        sz = [10000 10000]; %usually big enough
    end
    for i=1:length(G)
        p = G{i};
        S{i} = sub2ind(sz, p(:,1), p(:,2));
        len(i) = length(S{i});
    end
    U = {};
    for i=1:length(G)
        bunique = 1;
        k=find(len(i+1:end)==len(i)) + i;
        for j=k
            if isempty(setxor(S{i}, S{j}))
                bunique = 0;
                break;
            end
        end
        if bunique
            U{end+1,1} = G{i};
        end
    end
    