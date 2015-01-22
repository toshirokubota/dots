function tempDrawPoints(P, sel, varargin)
%draw edges returned from TriangulationSaliency.
    if ~exist('sel','var') | isempty(sel)
        sel = 1:size(P,1);
    end
%     figure;
    hold on;
    plot(P(sel,2), P(sel,1), '.', varargin{:}); %, 'MarkerSize', 20);
    axis image;
    set(gca, 'YDir', 'reverse');    
    hold off;
    