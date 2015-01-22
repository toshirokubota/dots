function tempSuperImposeContours(dmap, C1, C2, costs, P, F, sel, thres)
    if ~exist('sel','var') | isempty(sel)
        sel = 1:length(C1);
    end
    if ~exist('thres','var') | isempty(thres)
        thres = 0;
    end
    for i=1:length(C1)
        C1{i}(:,1:2)=C1{i}(:,1:2) + 1;
        C2{i}(:,1:2)=C2{i}(:,1:2) + 1;
    end
    for i=sel
        if costs(i) < thres 
            continue;
        end
        myimage(dmap);
        hold on;
        showPoints(P(:,1:2), 'o', 'LineWidth', 2, 'Color', [0 0 0]);
        tempDrawTriangles2(P, F, 0, [], 'Color', [1 1 1]);
        title(sprintf('%d: %f', i, costs(i)));
        showContours(C1, [i], [], [], 'LineWidth', 2, 'Color', [1 1 1]);
        showContours(C2, [i], [], [], 'LineWidth', 2, 'Color', [1 1 1]);
        pos = double(C1{i}(1,1:2));
        text(pos(2), pos(1), sprintf('%1.1f', costs(i)), 'FontSize', 24, ...
            'Color', [1 1 1]);
        pause;
    end
    