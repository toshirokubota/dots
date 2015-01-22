function dotGroupingExperiment(filespec, mode, nump)
    if ~exist('mode','var') | isempty(mode)
        mode = 1;
    end
    if ~exist('nump','var') | isempty(nump)
        nump = 50;
    end
    
    pathstr = fileparts(filespec);
    files = dir(filespec);
    results=[];
    for i=1:length(files)
        fprintf('%s (%d out of %d)\n', files(i).name, i, length(files));
        try
            C = shape2contour([pathstr '\' files(i).name]);
        catch
            continue;
        end
        if mode==1
            [P F E S R] = TriangulationCurving(C, nump);
            E=E(E(:,3)==4,:);
        elseif mode==2
            [P E] = DotGroupingByProximity(C, nump);
%             E(end+1,:)=[E(end,2), E(1,1)];
        end
        figure(1); clf;
        tempDrawEdges(P, E, [], 0, 'r-', 'LineWidth', 2);  
        pause;
    end
    
    
        