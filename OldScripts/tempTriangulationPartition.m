function [dmap peaks labels P F S] = tempTriangulationPartition(C, sz, thres, srate)
    if ~exist('thres','var') | isempty(thres)
        thres = 3;
    end
    if ~exist('srate','var') | isempty(srate)
        srate = 1;
    end    
    dthres = 3.0;
    
    [P F E S R O R2] = TriangulationCarving(C, srate, thres);
    figure(3);
    clf;
    tempDrawTriangles2(P, F, 0, []);
    
    [dmap lmap peaks] = TriangulationDistanceMap(S, sz, dthres);
    figure(1);
    clf;
    myimage(dmap);
    hold on;
    plot(S(:,2), S(:,1), 'o', 'Color', [1 1 1]);
    hold off;
    
    labels = TriangulationClustering(dmap, S, peaks);
    dif = sum(abs(labels - labels([2:end 1],:)), 2);
    [sv si] = sort(dif, 'descend');
    for i=1:length(si)
        fprintf('(%d, %d) ',si(i), sv(i));
    end
    fprintf('\n');
    
    %cmap = colormap('colorcube');
    cmap=[0 0 0; 1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1; 1 1 1;...
        .5 .25 .25; .25 .5 .25; .25 .25 .5];
    for lb=1:size(labels,2)
        figure(2);    
        clf;
        myimage(dmap>0);
        hold on;
        j=find(labels(:,lb));
        plot(S(j,2), S(j,1), 'o', 'Color', [1 1 1]);
        j=find(labels(:,lb)==0);
        plot(S(j,2), S(j,1), 'x', 'Color', [1 1 1]);
        text(double(S(:,2)+3), double(S(:,1)), num2str((1:size(S,1))'),...
            'Color', [1 1 1]);
        pause;
     end
    
%     for i=0:max(labels)
%         k=find(labels==i);
%         if isempty(k) 
%             continue; 
%         end
%         color = cmap(mod(i,size(cmap,1))+1,:);
%         plot(S(k,2), S(k,1), 'o', 'Color', color);
%         
%         str = sprintf('%d', i);
%         text(double(S(k,2)+3), double(S(k,1)), str, 'Color', [1 1 1]);
%         
%         k=find(peaks(:,4)==i);
%         if isempty(k) 
%             continue; 
%         end
%         plot(peaks(k,2), peaks(k,1), 'x', 'Color', color);
%     end
    
