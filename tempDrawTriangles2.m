function C = tempDrawTriangles2(P, T, tag, sel, varargin)
%draw edges returned from TriangulationSaliency.
    if ~exist('sel','var') | isempty(sel)
        sel = 1:size(T,1);
    end
    if ~exist('tag','var') | isempty(tag)
        tag = 0;
        dispon = 0;
    else
        dispon = 1;
        if numel(tag)==1
            tag = sel';
        elseif numel(tag)~=length(sel)
            error('DrawTriangle: tag and selection length mismatch.');
        end
    end
    P = double(P);
    holdstate = ishold();
    if holdstate==0
        clf;
    end
    hold on;
    C=[];
    for i=1:length(sel)
        t = T(sel(i),1:3);
        Q = P([t(:)' t(1)], [1 2]);
        C(end+1,:)=reshape(Q', [1 8]);
        plot(Q(:,2), Q(:,1), varargin{:});
        hold on;
        if dispon
%             text(mean(Q(:,2)), mean(Q(:,1)), num2str(T(i,4)));
            text(mean(Q(:,2)), mean(Q(:,1)), num2str(tag(i)));
        end
    end
    axis image;
    set(gca, 'YDir', 'reverse');    
    if holdstate==0
        hold off;
    end
    