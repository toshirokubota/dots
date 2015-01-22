function tempSimpleExample
    
    t = (0:7) * 2*pi/8 + pi/8;
    P = 10*[sin(t); cos(t)]';
    E = [8 1; 1 2; 2 3; 3 4; 5 6; 6 7; 7 8];
    j=length(t);
    P(end+1:end+6,:) = [1 12; 1 20; -1 12; -1 20; 0 13; 0 20];
    E(end+1:end+3,:) = [j+1 j+2; j+3 j+4; j+5 j+6];
    
%     tempDrawEdges(P,E, [], [], [], 'Color', [1 0 0], 'LineWidth', 2);
%     hold on;
%     showPoints(P, [], [], 'b.', 'MarkerSize', 14);
%     hold off;
    [O Z R] = StraightOffsetPolygons(P, E, 20, .1, 0);
    figure(1);
    tempP(P, E, R, -1);
    figure(2);
    showOffsetPolygons(P,E,O);
    