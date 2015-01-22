function S = pickSnapshots(O, t)
%Collect snapshots in O that have been taken before time t.

    S = {};
    for i=1:length(O)
        if ~isempty(O{i}) & O{i}(1,3)<=t
            S{end+1,1}=O{i};
        end
    end
    
    