function Q = normalizePoints(P, sz, margin)
%function Q = normalizePoints(P, sz, margin)
%Adjust the coordinates of points (P) so that they fit inside [sz(1) sz(2)] with a
%margin of [margin(1) margin(2)]

    maxc = max(P,[], 1);
    minc = min(P,[], 1);
    df = maxc - minc;
    df = max([1 1], df);
    if df(1)<=1
        margin(1) = sz(1)/2;
    end
    if df(2)<=1
        margin(2) = sz(2)/2;
    end
    scale = (sz-margin*2)./(maxc-minc);
    for i=1:size(P,1)
        Q(i,:) = (P(i,:)-minc).*scale + margin;
    end
    
