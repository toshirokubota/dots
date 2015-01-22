function P = readShape(shapefile)
%read a shape file (a list of coordinates. X and Y alternate.) and produce
%an N by 2 array.
    P = dlmread(shapefile);
    if size(P,2) < 2
        P = reshape(P, [2 size(P,1)/2])';
        P = P(:,[2 1]);
    end

