function simpleOffsetPolygons(P)
    if ~exist('P0', 'var') | isempty(P)
        P=[0 10; 10 0; 40 0; 45 10; 50 0; 70 0; 70 40; 25 45];
        P=P(end:-1:1,[2 1]);
    end
    addpath('..');
    [X Z W V U] = StraightOffsetPolygons(P, [],30, 3);
%     [z id] = unique(round(100*Z(:,1:4)),'rows');
%     Z = double(Z(sort(id),:));
    clf;
    plot(P(:,2), P(:,1), 'ko', 'MarkerSize', 12);
    hold on;
    for i=1:length(W)
        p=W{i};
        if(V(i,7)==4)
            plot(p([1:end 1],2), p([1:end 1],1), 'k:');
        else
            plot(p([1:end 1],2), p([1:end 1],1), 'k-');
        end
    end
    for i=1:size(Z,1)
        p=Z(i,1:4);
        plot(p(:,[2 4]), p(:,[1 3]), 'k-', 'LineWidth', 2);
        if(Z(i,8)>=4 && Z(i,8)<=7)
            plot(p(:,[2 4]), p(:,[1 3]), 'k.', 'MarkerSize', 24);
        end
%         text(Z(i,2)+2,Z(i,1)+2, num2str(i));
    end
    axis equal;
    axis([min(P(:,2))-5 max(P(:,2))+20 min(P(:,1))-5 max(P(:,1))+5]);
    axis off;
    
    