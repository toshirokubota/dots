function tempP(P, E, O, ptime)
    if ~exist('ptime','var') || isempty(ptime)
        ptime = 0;
    end
    fh = gcf();
    tempDrawEdges(P,E(:,1:2), [], [], [], 'Color', [0 0 0], 'LineWidth', 2);
    hold on;
    showPoints(P, [], [], 'b.', 'MarkerSize', 14);
    axis([min(P(:,2))-50 max(P(:,2))+50 min(P(:,1))-50 max(P(:,1))+50]);
    axis equal; %axis off;
    pause();
    for i=1:length(O)
        title(num2str(i));
        p=O{i};
        figure(fh);
        h=plot(p([1:end 1],2), p([1:end 1],1), 'r-', 'LineWidth', 4);
        if ptime > 0
            pause(ptime);
        else
            pause();
        end
        figure(fh);
        delete(h);
%         plot(p([1:end 1],2), p([1:end 1],1), 'b-', 'LineWidth', 2);
    end
    hold off;
%     set(gca, 'YDir', 'reverse');
%     axis equal
    
    