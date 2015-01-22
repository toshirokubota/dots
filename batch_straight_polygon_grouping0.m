function results = batch_straight_polygon_grouping(filespec)

    if ~exist('filespec','var') || isempty(filespec)
        filespec = '..\\shapeWithNoise\\*.txt';
    end
    
    files = dir(filespec);
    folder = fileparts(filespec);
    thres = 0.9;
    load('fdShapes'); %get DB, a collection of shapes.
    results=[];
    for i=1:length(files)
        filename = [folder '\\' files(i).name];
        P = readShape(filename);
        G = straight_polygon_grouping(P, thres);
        if length(G) > 10
            G = G(1:10);
        end
        [r f] = straight_polygon_recognition(P, G, db, 0);
        s = struct();
        s.filename = files(i).name;
        s.P = P;
        
        s.G = G;
        s.r = r;
        s.f = f;
        if isempty(results)
            results = s;
        else
            results(end+1) = s;
        end
    end
    