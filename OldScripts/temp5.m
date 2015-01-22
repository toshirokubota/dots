function temp5(P, B, X, Y)
    clf;
    h = gcf;
    axis equal;
    set(gca, 'YDir', 'reverse');
    hold on;
    if exist('B','var') && ~isempty(B)
        plot(B([1:end 1],2), B([1:end 1],1), 'b-');
    end
    %draw fronts
    colors={'b', 'g', 'c', 'm', 'r', 'c', 'y'};
    if exist('P','var') && ~isempty(P)
        plot(P(:,2), P(:,1), 'g.', 'MarkerSize', 18);
    end
    if(exist('Y','var') && ~isempty(Y))        
        for i=1:length(Y)
            pnts = Y{i};
            plot(pnts([1:end 1],2), pnts([1:end 1],1), 'b-');
        end
    end
    for i=1:size(X,1)-1
        ls = [colors{mod(i-1,length(colors))+1} 'x-'];
        title(sprintf('i=%d', i));
        plot(X(i:i+1,2), X(i:i+1,1), ls, 'LineWidth', 2);
        pause;
    end
    