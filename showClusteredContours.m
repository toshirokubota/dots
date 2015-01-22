function showClusteredContours(C, cl)
%SHOWCLUSTEREDCONTOURS shows contours colorcoded with their cluster labels.
%   C: contours
%   cl: cluster labels
%

%     figure;
%     clf;
    colors = colormap; %('colorcube');
%     colors = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1];
%     rid = 1:size(colors,1); %randperm(size(colors,1));
    rid = randperm(size(colors,1));
    hold off;
    for i=1:length(C)
        p = double(C{i});
        m = mod(cl(i)-1, size(colors,1))+1;
%         showContours(C, i, 0, 0, 'Color', colors(m,:));
        plot(p(:,2), p(:,1), 'Color', colors(rid(m),:), 'LineWidth', 2);
        hold on;
%         text(p(round(size(p,1)/2),2), p(round(size(p,1)/2),1), sprintf('%d', cl(i)));
        k = round(size(p,1)/2);
        text(p(k,2)-rand(1), p(k,1)+rand(1), sprintf('%d', cl(i))); %, 'Color', [1 0 0]);
    end
    axis image;
    set(gca, 'YDir', 'reverse');
    hold off;
