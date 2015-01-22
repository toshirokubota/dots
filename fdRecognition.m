function [ranks fits] = fdRecognition(P, db, nf)
%The scripts performs recognition of a given shape among a collection of
%shapes using fourier descriptors.
%Takes Nx2 shape vector (P) and find the best match in DB.
%DB is a struct array with NAME and SHAPE (a vector of points).
%NF is a number of fourier descriptors (defaulted to 10).
%It returns indices and fitness values sorted by the match fitness (the
%smaller the better).

    if ~exist('nf','var') | isempty(nf)
        nf = 10;
    end

    f = frdcd(P);
    fits=zeros(length(db));
    for i=1:length(db)
        g = frdcd(db(i).P);
        nf0 = min([nf, length(f), length(g)]);
        df = f(1:nf0) - g(1:nf0);
        fits(i) = sqrt(df.*df);
    end
    [fits ranks] = sort(fits);
