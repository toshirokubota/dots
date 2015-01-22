function [results] = plotDotExperiments(filespec, K)
%Run dotExperiment and plot results (inside dotExperiments with dispOn).
    if ~exist('filespec','var') | isempty(filespec)
        filespec = 'C:\Toshiro\Research\NSF2011\Summer2012\Data\Shapes\*.shape';
    end
    if ~exist('K','var') | isempty(K)
        K = 50;
    end
    dispon = 1;
    results = dotExperiments(filespec, K, 0, dispon);
    