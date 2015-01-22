function [c v M] = ellipseFit(pnts)
    c = mean(pnts);
    pnts = pnts - repmat(c, [size(pnts,1) 1]);
    a = mean([pnts(:,1).*pnts(:,1) pnts(:,1).*pnts(:,2) pnts(:,2).*pnts(:,2)]);
    det = sqrt((a(1)-a(3))^2+4*a(2)*a(2));
    v(1) = (a(1)+a(3)+det)/2;
    v(2) = (a(1)+a(3)-det)/2;
    u1(1) = -(-a(1)+a(3)-det)/(2*a(2));
    u1(2) = 1;
    u1 = u1 / norm(u1);
    u2(1) = -(-a(1)+a(3)+det)/(2*a(2));
    u2(2) = 1;
    u2 = u2 / norm(u2);
    M=[u1' u2'];
    
    clf;
    plot(pnts(:,1), pnts(:,2), 'bo');
    hold on;
    
    t=-pi:.1:pi;
    u = [cos(t)' sin(t)'];
    N = [v(1)*M(:,1) v(2)*M(:,2)];
    dp = 3 * u * N;
    x = dp * M(1,:)';
    y = dp * M(2,:)';
    plot(x, y, 'r-');
    quiver(0, 0, v(1)*M(1,1), v(1)*M(2,1));
    quiver(0, 0, v(2)*M(1,2), v(2)*M(2,2));
    axis equal;
    
    
    