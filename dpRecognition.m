function [ranks fits] = dpRecognition(P, db)
%The scripts performs recognition of a given shape among a collection of
%shapes using dynamic programming based shape matching (shapeMatchDp).
%Takes Nx2 shape vector (P) and find the best match in DB.
%DB is a struct array with NAME and SHAPE (a vector of points).
%It returns indices and fitness values sorted by the match fitness (the
%smaller the better).

    fits=zeros(length(db),1);
    for i=1:length(db)
%         fits(i) = shapeMatchDP(double(P(:,1:2)), double(db(i).P(:,1:2)));
        Q = db(i).P(:,1:2);
        fits(i) = DotOperations('shapematch', double(P(:,1:2)), double(Q));
        fits(i) = fits(i) / size(Q,1);
    end
    [fits ranks] = sort(fits);
