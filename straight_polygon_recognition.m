function [R F] = straight_polygon_recognition(P, G, db, disp)
    
    if disp ~= 0
        showPoints(P, [], [], 'b.', 'MarkerSize', 10);
        hold on;
    end
    R=[];
    for i=1:length(G)
        p = G{i};
        [ranks fits] = areaRecognition(p, db);
        R(i,1:5)=ranks(1:5)';
        F(i,1:5)=fits(1:5)';
        for j=1:length(ranks)
            r=ranks(j);
            fprintf('%d: %s %f\n', j, db(r).name, fits(j));
        end
        fprintf('\n');
        if disp ~= 0
            h = plot(p([1:end 1],2), p([1:end 1],1), 'g-', 'LineWidth', 2);
            r = ranks(1);
            title(sprintf('%s %3.3f', db(r).name, fits(1)));
            fprintf('hit Enter');
            pause();
            fprintf(' continuing...\n');
            delete(h);
        end
    end
    if disp ~= 0
        hold off;
    end
    