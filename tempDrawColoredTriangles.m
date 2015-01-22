function tempDrawColoredTriangles(P, T, labels, sel, cmap, varargin)
%draw edges returned from TriangulationSaliency.
    if ~exist('sel','var') | isempty(sel)
        sel = 1:size(T,1);
    end
    if ~exist('cmap','var') | isempty(cmap)
%         cmap = colormap('colorcube');
        cmap = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1; 1 1 1];
%         cmap = cmap(randperm(size(cmap,1)),:);
%         cmap = colormap();
    end
    
    P = double(P);
%     figure;
    labels = normalize(labels, size(cmap,1)); 
    holdstate = ishold();
    if holdstate==0
        clf;
    end
    hold on;
    for i=sel
        t = T(i,[1:3 1]);
        Q = double(P([t(:)' t(1)], [1 2]));
        if labels(i)==0
            color = [0 0 0];
        else
            k = mod(labels(i)-1, size(cmap,1))+1;
            color = cmap(k,:);
        end
%         plot(Q(:,2), Q(:,1), 'Color', color, varargin{:});
        patch(Q(:,2), Q(:,1), color, varargin{:});
        mv = mean(Q);
    end
    axis image;
    set(gca, 'YDir', 'reverse');    
    if holdstate==0
        hold off;
    end
    
function X = normalize(X, len)
    X = double(X);
    if range(X)<=0
        return;
    end
    X = floor(((X-min(X))/range(X))*(len-1))+1;
    