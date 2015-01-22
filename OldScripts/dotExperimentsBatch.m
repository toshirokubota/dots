function [results pdata] = dotExperimentsBatch(filespec)
%Run dotExperiment multiple times with different number of contour points.
    results=[];
    pdata=[];
    for nump=30:10:200
        result = dotExperiments(filespec, nump, 0, 0);
        results(end+1:end+size(result,1),:) = result;
        pdata(end+1,:) = [nump ...
            mean(result(:,5)) std(result(:,5)) min(result(:,5)) max(result(:,5)) ...
            mean(result(:,6)) std(result(:,6)) min(result(:,6)) max(result(:,6))];
    end
    