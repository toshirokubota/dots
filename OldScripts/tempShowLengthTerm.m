function tempShowLengthTerm(t, gamma)

    x = 0:t/20:t*3;
    y = 1-1./(1+exp(-gamma*(x-t)/t));
    figure;
    plot(x, y, 'b-');
    