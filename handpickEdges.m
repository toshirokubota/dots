function [P2 E2] = handpickEdges(P, E, idx, roi)
%This script selects a subset of points in P specified by IDX and
%corresponding edges that are contained in the subset of points.
%This is used for debugging by removing irrelevant part of data.
    if exist('idx','var') && ~isempty(idx)
        P2 = P(idx,:);
    elseif exist('roi','var') && length(roi)==4
        idx = find(P(:,1)>=roi(1)&P(:,1)<=roi(2)&...
            P(:,2)>=roi(3)&P(:,2)<=roi(4));
        P2 = P(idx,:);
    end
    E2 = [];
    for i=1:size(E,1)
        j1 = find(idx==E(i,1));
        j2 = find(idx==E(i,2));
        if ~isempty(j1) && ~isempty(j2)
            E2(end+1,:)=[j1 j2];
        end
    end
   
    %remove isolated points
    torem=[];
    for i=1:size(P2,1)
        if isempty(find(E2(:)==i))
           torem(end+1)=i;
        end
    end
    torem=torem(end:-1:1); %reverse it
    for i=torem
        P2(i,:)=[];
        k = find(E2(:)>i);
        E2(k) = E2(k) - 1;
    end
    
        
        