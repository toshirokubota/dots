function [ranks fits] = areaRecognition(P, db)
%The scripts performs recognition of a given shape among a collection of
%shapes based on the overlap area.
%Takes Nx2 shape vector (P) and find the best match in DB.
%DB is a struct array with NAME and SHAPE (a vector of points).
%It returns indices and fitness values sorted by the match fitness (the
%smaller the better).

%     P = normalizePoints(P);
    fits=zeros(length(db),1);
    for i=1:length(db)
        Q = db(i).P;
%         Q = normalizePoints(Q);
        area = OverlapArea(P(:,1:2), Q(:,1:2));
        fits(i) = 1.0 - area(3)/(area(1)+area(2)-area(3));
    end
    [fits ranks] = sort(fits);

function P = normalizePoints(P)
    x = max(P);
    n = min(P);
    P(:,1) = (P(:,1)-n(1)) / (x(1)-n(1));
    P(:,2) = (P(:,2)-n(2)) / (x(2)-n(2));

