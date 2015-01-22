function [results2 pdata] = dotExperimentsBatchR(filespec)
%Run dotExperiment multiple times with different sets of randomly selected 
%points.
    results2=[];
    pdata=[];
    nump = 50;
    for r=0.2:0.2:0.8
        results=[];
        for i=1:10
            result = dotExperiments(filespec, nump, r, 0);
            results(end+1:end+size(result,1),:) = result;
        end
        pdata(end+1,:) = [nump r ...
            mean(results(:,5)) std(results(:,5)) min(results(:,5)) max(results(:,5)) ...
            mean(results(:,6)) std(results(:,6)) min(results(:,6)) max(results(:,6))];
        results2(end+1:end+size(results,1),:)=results;
    end