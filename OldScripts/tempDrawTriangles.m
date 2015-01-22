function tempDrawTriangles(E, sel)
%draw edges returned from NonConvexHull. Color code them based on their
%types.

    if ~exist('sel','var') | isempty(sel)
        sel = 1:max(E(:,7));
    end
%     figure; 
    hold on;
    E = E';
    ls={'k-', 'r-', 'b-', 'g-', 'm-', 'c-', 'y-'};
%     cm = colormap('colorcube');
    if size(E,2)>=7
        idx = randperm(max(E(:,7)));
        cm = randomColormap(length(sel));
    end
    for i=1:size(E,1)
        p = E(i,:);
        if length(p) >= 7
            g = (p(7));
            j = find(g==sel);
            if isempty(j)
                continue;
            end
            j = mod(g-1, size(cm,1))+1;
            plot(p([2 4 6 2]), p([1 3 5 1]), '-', 'Color', cm(j(1),:), 'LineWidth', 5);
        else
            plot(p([2 4 6 2]), p([1 3 5 1]), '-');
        end
    end
    axis image;
    set(gca, 'YDir', 'reverse');
    
    
function cm = randomColormap(c)
    if c <=64
        cm = colormap('colorcube');
        return;
    else
        k = ceil(c^(1/3));
        x = ((1:k)'-1)/k;
        z = ones(length(x)^2,1);
        r = kron(x, z);
        ir = randperm(length(r));
        ig = randperm(length(r));
        ib = randperm(length(r));
        cm = [r(ir) r(ig) r(ib)];
    end
    
    