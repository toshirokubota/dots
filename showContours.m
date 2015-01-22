function showContours(C, sel, salOn, textOn, varargin)
    if ~exist('sel','var') | isempty(sel)
        sel = 1:length(C);
    end
%     if ~exist('ls','var') | isempty(ls)
%         ls='r-';
%     end
    if ~exist('salOn','var') | isempty(salOn)
        salOn=0;
    end
    if ~exist('textOn','var') | isempty(textOn)
        textOn=0;
    end

%     clf;
    holdstate = ishold();
    hold on;
    showSaliency = salOn;
    if showSaliency
        cm = colormap('colorcube');
%         cm = colormap('jet');
    end
    for i=sel
        p = double(C{i});
        %p(:,1:3)=p(:,1:3)+1; %comment this if the original coordinate is preferred.
        if size(p,2)>=7 && showSaliency
%             sal = 0.9*(p(:,7)>.5);
            sal = p(:,7);
            sal = mod(int32(sal*(length(cm)-1)), length(cm)) + 1;
%             sal(sal<=0)=1;
            for j=1:size(p,1)
                plot(p(j,2), p(j,1), '.', 'Color', cm(sal(j),:), varargin{:});
%                 if j==1
%                     text(p(j,2), p(j,1), sprintf('%d', p(j,7)));
%                 elseif p(j,7)~=p(j-1,7)
%                     text(p(j,2), p(j,1), sprintf('%d', p(j,7)));
%                 end
            end
        else
            plot(p(:,2), p(:,1), varargin{:});
            if size(p,1)>2 & textOn
%                 text(double(p(1,2)), double(p(1,1))+5, sprintf('C-%d', i), 'Color', [0, 0, 1]);
                plot(p(1,2), p(1,1), 'go', 'MarkerSize', 5);
                plot(p(end,2), p(end,1), 'bo', 'MarkerSize', 5);
                k = round(size(p,1)/2);
                text(p(k,2), p(k,1), sprintf('%d', i));
            end
        end
    end
    axis image;
    set(gca, 'YDir', 'reverse');
    if holdstate==0
        hold off;
    end
    