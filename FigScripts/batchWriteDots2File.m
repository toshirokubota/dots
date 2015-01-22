function batchWriteDots2Files(filespec)
    if ~exist('filespec','var') || isempty(filespec)
        filespec = 'MAT\\*.mat';
    end
    
    files = dir(filespec);
    folder = fileparts(filespec);
    
    for i=1:length(files)
        filename = [folder '\\' files(i).name];
        t = load(filename);
        [path fname ext] = fileparts(files(i).name)
        outfilename = [fname '.shape'];
        fid = fopen(outfilename, 'wt');
        for j=1:size(t.P0,1)
            fprintf(fid, '%f\t%f\n', t.P0(j,1:2));
        end
        fclose(fid);
    end
