function tempDrawPairs(P, T, R, varargin)
    P = double(P);
    holdstate = ishold();
    if holdstate==0
        clf;
    end
    hold on;
    tempDrawTriangles2(P, T);
    showPoints(P, [], [], 'b.', 'MarkerSize', 14);
    vals = unique(R(:,4))';
    thres = 5;
    
    for val = vals
        i=find(R(:,4)==val);
        if R(i(1),5) < thres
            continue;
        end
        j=unique(R(i,[1 2 3]));
        h = plot(P(j,2), P(j,1), 'r.', 'MarkerSize', 14);
        axis image;
        set(gca, 'YDir', 'reverse'); 
        title(sprintf('%d in %d', val, length(vals)))
        pause;
        delete(h);
    end
    if holdstate==0
        hold off;
    end

% function tempDrawPairs(P, R, varargin)
%     P = double(P);
%     holdstate = ishold();
%     if holdstate==0
%         clf;
%     end
%     hold on;
%     for i=1:size(R,1)
%         t=R(i,[2 1 3]);
%         Q = P([t(:)], [1 2]);
%         plot(Q(:,2), Q(:,1), varargin{:});
%     end
%     showPoints(P, [], [], '.', 'MarkerSize', 14);
%     axis image;
%     set(gca, 'YDir', 'reverse');    
%     if holdstate==0
%         hold off;
%     end
%  