function p = shape2points(shapefile)
%read a shape (dot) file and reshape into N by 2 matrix.

p = dlmread(shapefile);
p = reshape(p, [2, length(p)/2])';

p = p(:,[2 1]);

