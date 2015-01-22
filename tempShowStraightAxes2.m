function tempShowStraightAxes2(A, P)

    clf;
    axis equal;
    set(gca, 'YDir', 'reverse');
    hold on;
%     for i=1:length(A.particles)
%         p = A.particles(i);
%         plot([p.p0(2) p.p(2)], [p.p0(1) p.p(1)], 'g-');
%         plot([p.p0(2)], [p.p0(1)], 'k.', 'MarkerSize', 14);
%     end
    showPoints(P, [], [], 'k.', 'MarkerSize', 18);
%     colors={'y', 'b', 'c', 'm', 'r', 'k'}; 
    cm = colormap('colorcube');
    K = length(A.polygons(1).particles);
    for i=1:length(A.polygons)
        poly = A.polygons(i);
        if(length(poly.particles) > K/8)
            continue;
        end
        x=[];
        y=[];
        k = mod(i-1, size(cm,1))+1;
        for j=1:length(poly.particles)
            p = A.particles(poly.particles(j));
            x(j)=p.p0(2);
            y(j)=p.p0(1);
        end
        title(sprintf('%d: %d -> %d (%d)',...
            i, poly.parent_id, poly.id, length(poly.particles)));
%         h = plot(x([1:end 1]), y([1:end 1]), '-', 'LineWidth', 2, 'Color', cm(k,:));
        h = patch(x([1:end 1]), y([1:end 1]), cm(k,:));
        pause;
%         delete(h);
%         plot(x([1:end 1]), y([1:end 1]), 'g-');
    end
    hold off;

    function q = position(p, t)
        t = t - p.created;
        q(1) = p.p0(1) + t * p.v(1);
        q(2) = p.p0(2) + t * p.v(2);
        