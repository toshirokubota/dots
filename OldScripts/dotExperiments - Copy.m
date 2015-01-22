function dotExperiments(filespec, nump, rnd)
    if ~exist('nump','var') | isempty(nump)
        nump = 100;
    end
    if ~exist('rnd', 'var') | isempty(rnd)
        rnd = 0;
    end
    nump = round(nump /(1.0-rnd));
    pathstr = fileparts(filespec);
    files = dir(filespec);
    for i=1:length(files)
        fprintf('%s (%d out of %d)\n', files(i).name, i, length(files));
        try
            Q = shape2points([pathstr '\' files(i).name]);
        catch
            continue;
        end
        Q = normalizePoints(Q, [512, 512], [5 5]);
        Q = samplePoints(Q, nump);
        Q = randomRemoval(Q, 1-rnd);
        [P0 F E1] = TriangulationCurving(Q);
        E1=E1(E1(:,3)==4,:);
        E2 = DotGroupingByProximity(Q);
        s1 = score(E1, Q);
        s2 = score(E2, Q);
        fprintf('%f vs %f\n', s1, s2);
        
        figure(1); clf;
        tempDrawEdges(Q, E1, [], [], 'LineWidth', 2); 
        hold on; showPoints(Q, 'ro'); hold off;
        axis([1 512 1 512]);
        figure(2); clf;
        tempDrawEdges(Q, E2, [], [], 'LineWidth', 2); 
        hold on; showPoints(Q, 'ro'); hold off;
        axis([1 512 1 512]);
        pause;
    end
    
function s = score(E, P)
    count = 0;
    n = size(P,1);
    for i=1:size(E,1)
        dif = mod(E(i,1)+n-E(i,2), n);
        if dif==1 || dif==n-1
            count = count + 1;
        end
    end

    s = count / size(E,1);
        