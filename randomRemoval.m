function Q = randomRemoval(P, perc)
%Randomly remove points from P.
%PERC is the percentage of points that are going to be kept.
%It defaults to 0.9.
    if ~exist('perc','var') | isempty(perc)
        perc = 0.9;
    end
    if perc < 0 || perc >1.0
        error('2nd parameter has to be between 0 and 1. %f is given.\n', perc);
    end
    nump = int32(size(P,1)*perc);
    j = randperm(size(P,1));
    Q=P(sort(j(1:nump)),:);
    
    