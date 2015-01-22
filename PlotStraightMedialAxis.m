function PlotStraightMedialAxis(M)
    Y = M(:,1:2:end);
    X = M(:,2:2:end);
    n = size(X,1);
    k = size(X,2);
    hp=[];
    hp2=[];
    hp(1) = plot(X([1:n 1],1), Y([1:n 1], 1), 'b-');
    hold on;
    hp2(1) = plot(X(:,1), Y(:,1), 'r.', 'MarkerSize', 8);
    set(gca, 'YDir', 'reverse');
    title('1');
    j=2;
    while j<=k
        [x y b] = ginput(1);
        if b==3
            if ~isempty(hp)
                k2 = length(hp);
                delete (hp(k2));
                delete (hp2(k2));
                hp(k2)=[];
                hp2(k2)=[];
                j = j - 1;
                title(sprintf('%d', j));
            end
        else
            hp(end+1) = plot(X([1:n 1],j), Y([1:n 1], j), 'b-');
            hp2(end+1) = plot(X(:,j), Y(:,j), 'r.', 'MarkerSize', 8);
            title(sprintf('%d', j));
            j = j + 1;
        end
    end
    
    