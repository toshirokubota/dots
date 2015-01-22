function showPoints(P, labels, S, varargin)
    P = double(P);
    holdstate = ishold();
    if holdstate==0
        clf;
    end
    hold on;
    if exist('S','var') & length(S)==size(P,1)
        cm = colormap('colorcube');
%         S = normalize(S, size(cm,1)-5); 
        for i=1:size(P,1)
            plot(P(i,2), P(i,1), '.', 'Color', cm(S(i),:), varargin{:});
        end
    else
        x = P(:,2);
        y = P(:,1);
        plot(x, y, varargin{:});
    end
    if exist('labels','var') & length(labels)==size(P,1)
        text(P(:,2), P(:,1)+1, num2str(labels));
    end
    if holdstate==0
        hold off;
    end        
    axis image;
    set(gca, 'YDir', 'reverse');    

    axis([min(P(:,2))-1 max(P(:,2))+1 min(P(:,1))-1 max(P(:,1))+1]);
    %     hold on;
%     for i=1:length(x)
%         text(x(i)+2, y(i), sprintf('%i',i));
%     end

function X = normalize(X, len)
    X = double(X);
    if range(X)<=0
        return;
    end
    X = floor(((X-min(X))/range(X))*(len-1))+1;
    