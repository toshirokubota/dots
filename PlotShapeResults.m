function plotShapeResults(filespec, mode, K)

    if ~exist('filespec','var') | isempty(filespec)
        filespec = 'C:\Toshiro\Research\NSF2011\Summer2012\Data\Shapes\*.shape';
    end
    if ~exist('mode','var') | isempty(mode)
        mode = 'surface';
    end
    if ~exist('K', 'var') | isempty(K)
        K=50;
    end
    
    files = dir(filespec);
    pathstr = fileparts(filespec);
    for i=1:length(files)
        if strcmp(mode, 'surface')
            [result Q E] = doExperiments([pathstr '\' files(i).name], K, 0, 0);
            figure;
            tempDrawEdges(Q, E, [], [], 'LineWidth', 2); 
            hold on; showPoints(Q, 'ro'); hold off;
            axis([1 512 1 512]);
        end
    end
    