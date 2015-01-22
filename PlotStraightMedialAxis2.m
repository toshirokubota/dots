function PlotStraightMedialAxis2(X, Y)

    for i=1:length(X)
        x = X{i};
        y = Y{i};
        showPoints([x' y'], [], [], '.', 'MarkerSize', 14);
        hold on;
        pause;
    end
    