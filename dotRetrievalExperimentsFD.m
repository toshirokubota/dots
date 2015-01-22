function [X, Z, names] = dotRetrievalExperimentsFD(filespecDb, shapeSpec, numps)
%Perform shape retrieval using Fourier coefficients after triangulation curving.
%Usage:
%[X, Z, names] = dotRetrievalExperiments(filespecDb, shapeSpec, numps)
%Input:
%FIELSPECDB: a set of shape files that constitute the database.
%SHAPESPEC: a set of query shapes whose signatures will be compared against
%those in the database.
%NUMPS: a set of numbers of sample points. Retrieval is tested on each
%sample size.
%
%Output:
%X: retrieval scores
%Z: signatures of the database shapes.
%names: names of shapes in the database.
%

    if ~exist('numps','var') | isempty(numps)
        numps = 30:10:200;
    end
    if ~exist('shapeSpec','var') | isempty(shapeSpec)
        shapeSpec=filespecDb;
    end
    %compute the fourier descriptors for each shape
    pathstr = fileparts(filespecDb);
    files = dir(filespecDb);    
    Z=[];
    names={};
    ndesc=10; %number of coefficients
    for i=1:length(files)
        fprintf('%s (%d out of %d)\n', files(i).name, i, length(files));
        try
            Q = shape2points([pathstr '\' files(i).name]);
            z = frdcd(Q);
            Z(:,end+1)=z(1:ndesc,1);
            names{end+1} = files(i).name;
        catch
            continue;
        end
    end

    %calculate similarity scores
    pathstr = fileparts(shapeSpec);
    files = dir(shapeSpec);        
    X=[];
    count=0;
    for i=1:length(files)
        fprintf('%s (%d out of %d)\n', files(i).name, i, length(files));
        try
            P = shape2points([pathstr '\' files(i).name]);
        catch
            continue;
        end
        count = count + 1;
        S=[];
        nump=numps;
        for j=1:length(nump)
            Q = samplePoints(P, nump(j));
            [P0 F E R] = TriangulationCarvingV1(Q);
%             Eb=E(E(:,3)==4,:);
%             R = trace(P0, Eb);
            z = frdcd(R);
            S(j,:)=match_score(z(1:ndesc), Z);
        end
        if isempty(X)
            X.scores = S;
            X.name = files(i).name;
            X.numps = numps;
        else
            X(end+1).scores = S;
            X(end).name = files(i).name;
            X(end).numps = numps;
        end
    end
    
function scores = match_score(z, Z)
    df = repmat(z, [1 size(Z,2)]) - Z;
    scores = sqrt(sum(df.*df));
    scores = scores/min(scores);

function T = trace(P, E)
    prev = E(1,2);
    first = E(1,1);
    T=[P(first,:); P(prev,:)];
    E(1,:)=[];
    while ~isempty(E)
        j=find(E(:,1)==prev | E(:,2)==prev);
        if isempty(j) | length(j)>1
            error('trace: Illegal contour formation. Cannot continue...');
        else
            if E(j,1)==prev
                T(end+1,:)=P(E(j,2),:);
                prev = E(j,2);
            else
                T(end+1,:)=P(E(j,1),:);
                prev = E(j,1);
            end
            E(j,:)=[];
        end
    end
        
            
        