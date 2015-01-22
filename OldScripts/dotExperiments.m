function [result Q E1] = dotExperiments(filespec, nump, rnd, dispOn)
%Compare triangulation based and contour based gropuing of shapes.

    if ~exist('nump','var') | isempty(nump)
        nump = 100;
    end
    if ~exist('rnd', 'var') | isempty(rnd)
        rnd = 0;
    end
    if ~exist('dispOn','var') | isempty(dispOn)
        dispOn=1;
    end
    nump2 = round(nump /(1.0-rnd));
    pathstr = fileparts(filespec);
    files = dir(filespec);
    result = [];
    for i=1:length(files)
        fprintf('%s (%d out of %d)\n', files(i).name, i, length(files));
        try
            Q = shape2points([pathstr '\' files(i).name]);
        catch
            continue;
        end
        Q = normalizePoints(Q, [512, 512], [5 5]);
        Q = samplePoints(Q, nump2);
        Q = randomRemoval(Q, 1-rnd);
        [P0 F E1 tr inside orig] = TriangulationCarvingV1(Q);
        E1=E1(E1(:,3)==4,:);
        E2 = DotGroupingByProximity(Q);
        E0 = groundTruth(Q);
        s1 = score(E1, E0);
        s2 = score(E2, E0);
        fprintf('%f vs %f\n', s1, s2);
        result(end+1,:)=[nump size(Q,1) size(E1,1) size(E2,1) s1 s2 nump2 rnd];
        
        if dispOn
            printFolder = 'C:\cygwin\home\kubota\Figures\Dots\ResultsPics\';
            [pathstr2 filestr extstr] = fileparts(files(i).name);
            figure(1); clf;
            tempDrawTriangles2(Q, orig, [], [], 'k:'); 
            hold on; tempDrawEdges(Q, E1, [], [], 'LineWidth', 3); 
            showPoints(Q(:,1:2), [], [], 'ro', 'LineWidth', 5); hold off;
            axis([1 512 1 512]);
            axis off
            title(sprintf('%3.3f', s1), 'FontSize', 36);
            print(gcf, '-depsc', [printFolder filestr '_Sc.eps']);
            print(gcf, '-deps', [printFolder filestr '_Sg.eps']);
            print(gcf, '-dpng', [printFolder filestr '_S.png']);
            figure(2); clf;
            tempDrawEdges(Q, E2, [], [], 'LineWidth', 3); 
            hold on; showPoints(Q, [], [], 'ro', 'LineWidth', 5); hold off;
            axis([1 512 1 512]);
            axis off
            title(sprintf('%3.3f', s2), 'FontSize', 36);
            print(gcf, '-depsc', [printFolder filestr '_Cc.eps']);
            print(gcf, '-deps', [printFolder filestr '_Cg.eps']);
            print(gcf, '-dpng', [printFolder filestr '_C.png']);
%             pause;
        end
    end
    
function s = score(E, G)
    count = 0;
    for i=1:size(E,1)
        j1 = find(G(:,1)==E(i,1) & G(:,2)==E(i,2));
        j2 = find(G(:,1)==E(i,2) & G(:,2)==E(i,1));
        if ~isempty(j1) | ~isempty(j2)
            count = count + 1;
        end
    end
    s = count / size(E,1);

function E = groundTruth(P)
    for i=1:size(P,1)-1
        E(i,:)=[i i+1];
    end
    E(end+1,:)=[size(P,1) 1];
        