function P = edgemap2points(em)

    [y x] = ind2sub(size(em), find(em));
    P = [y, x];

