function db = fdDatabase(filespec)
%compute Fourier descriptors on shapes in the given folder.

    files = dir(filespec);
    folder = fileparts(filespec);
    for i=1:length(files)
        filename = [folder '\' files(i).name];
        P0 = readShape(filename);
        if strcmp(files(i).name, 'circle.shape') || strcmp(files(i).name, 'square.shape')
            P = P0;
        else
            P = P0(1:10:end,:);
        end
        s = struct();
        s.P0 = P0;
        s.P = P;
        s.name = files(i).name(1:end-6);
        s.fd = frdcd(P);
        db(i) = s;
    end
    

    