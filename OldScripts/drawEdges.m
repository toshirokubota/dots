function tempDrawEdges(P, E, S, dispon, mode, varargin)
%draw edges returned from NonConvexHull. Color code them based on their
%types.
    if ~exist('dispon','var') | isempty(dispon)
        L = [];
        dispon=0;
    else
        if length(dispon)==size(E,1)
            L=dispon;
            dispon=1;
        elseif dispon==1
            L=1:size(E,1);
        end
    end
    if ~exist('S','var') | isempty(S)
        S = [];
    end
    if ~exist('mode','var') | isempty(mode)
        mode = 'normalize';
    end
%     figure;
%     hold off;
    P = double(P);
    E = double(E);
%     cm = 1-[(0:63)' (0:63)' (0:63)']/63; %colormap('jet');
    cm = colormap('jet');
    switch lower(mode)
        case {'normalize'}
            S = normalize(S, size(cm,1)); 
        case {'heq'}
            S = normalizeHeq(S, size(cm,1)); 
%         otherwise
%             pass;
    end            
    holdstate = ishold();
    if holdstate==0
        clf;
    end
    hold on;
    for i=1:size(E,1)
        p=P(E(i,1),:);
        q=P(E(i,2),:);
        if ~isempty(S)
            idx = S(i,:); %mod(S(i,1), size(cm,1))+1;%int32((size(cm,1)-1) * S(i,1)+1);
            if idx==1
                plot([p(2) q(2)], [p(1) q(1)], 'Color', cm(idx,:));
            else
                plot([p(2) q(2)], [p(1) q(1)], 'Color', cm(idx,:), varargin{:});
            end
        else
            plot([p(2) q(2)], [p(1) q(1)], varargin{:});
        end
        if dispon 
%             text((p(2)+q(2))/2, (p(1)+q(1))/2, sprintf('%2.2f', S(i,1)));
            text((p(2)+q(2))/2, (p(1)+q(1))/2, num2str(L(i)));
        end
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
    
function X = normalizeHeq(X, len)
    X = double(X);
    [s si] = sort(X);
    for i=1:length(X)
        X(i) = find(si==i);
    end
    X = floor((len-1)*(X-1)./(length(X)-1))+1;
    
% %     figure; 
%     hold on;
%     E = E';
%     ls={'k-', 'r-', 'b-', 'g-', 'm-', 'c-', 'y-'};
%     for i=1:size(E,1)
%         type = E(i,5)+1;
%         plot(E(i,[2 4]), E(i,[1 3]), ls{type});
%     end
%     E(:,[6 7]) = E(:,[6 7])/max(E(:,6));
%     cm = colormap('jet');
%     d = sum(E(:,[6 7]),2)/2.0;
%     d = floor(d * (size(cm,1)-1) + 1);
%     for i=1:size(E,1)
%         plot(E(i,[2 4]), E(i,[1 3]), 'Color', cm(d(i),:));
%     end
%     cm = colormap('jet');
%     sal = E(:,6);
%     for i=1:size(E,1)
%         k = floor(sal(i)*length(cm));
%         if k==0 
%             k=1;
%         end
%         plot(E(i,[2 4]), E(i,[1 3]), 'Color', cm(k,:));
%     end
%     axis image;
%     set(gca, 'YDir', 'reverse');
    