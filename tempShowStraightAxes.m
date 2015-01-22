function tempShowStraightAxes(A)

    clf;
    axis equal;
    set(gca, 'YDir', 'reverse');
    hold on;
    for i=1:length(A.particles)
        p = A.particles(i);
        plot([p.p0(2) p.p(2)], [p.p0(1) p.p(1)], 'g-');
        plot([p.p0(2)], [p.p0(1)], 'k.', 'MarkerSize', 14);
    end
    for i=1:length(A.polygons)
        poly = A.polygons(i);
        t = poly.created;
        for j=1:length(poly.particles)
            k = mod(j, length(poly.particles)) + 1;
            p = A.particles(poly.particles(j));
            q = A.particles(poly.particles(k));
            ploc = position(p, t);
            qloc = position(q, t);
            plot([ploc(2) qloc(2)], [ploc(1) qloc(1)], 'r-');
        end
    end
    hold off;

    function q = position(p, t)
        t = t - p.created;
        q(1) = p.p0(1) + t * p.v(1);
        q(2) = p.p0(2) + t * p.v(2);
        