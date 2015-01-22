function [C bm tm] = bmp2shape(bmpfile, shapefile, srate)
%Convert a bmp image (binary image) into contours.
    if ~exist('srate','var') | isempty(srate)
        srate = 1; %sampling rate
    end
    bm = imread(bmpfile);
    bm = double(bm(:,:,1));
%     bm = bm(:,:)<100;
    tm = edge(bm, 'canny');
    tm = bwmorph(tm, 'thin', Inf);
    C = ContourPrep(tm); 
%     C=ContourBreak(C);
    
    fid = fopen(shapefile, 'wt');
    for i=1:length(C)
        pnts = C{i};
        for j=1:srate:size(pnts,1)
            fprintf(fid, '%f\n%f\n', pnts(j,2:-1:1));
        end
    end
    fclose(fid);
    
    