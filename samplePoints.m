function Q = samplePoints(P, nump, mode)
%Sample points either uniformly (MODE=1) or randomly (MODE=2).
%NUMP gives a desired number of sampled points.

    if ~exist('mode','var') | isempty(mode)
        mode = 1;
    end
    
    nump = min(nump, size(P,1));
    if mode==1
        space = round(size(P,1)/nump);
        Q=[];
        for i=1:space:size(P,1)
            Q(end+1,:)=P(i,:);
        end        
    elseif mode==2
        j = randperm(size(P,1));
        Q = P(j(1:nump),:);
    else
        error('unsupported mode of %d', mode);
    end
    