function [area1 area2] = convexityMeasure(P, F)
    pnts=[];
    for i=1:size(F,1)
        pnts(end+1:end+3,1:2) = P([F(i,1:3)],1:2);
    end
    
    pnts = unique(pnts, 'rows');
    T = delaunayn(pnts);
    
%     figure;
    tempDrawTriangles2(pnts, T, [], [], 'LineWidth', 2, 'Color', [1 0 0]);
    hold on;
    tempDrawTriangles2(P, F, [], [], 'LineWidth', 2, 'Color', [0 0 1]);
    hold off;
    
    area1 = computeArea(P, F);
    area2 = computeArea(pnts, T);
    fprintf('area1 = %f, area2 = %f, ratio = %f\n', area1, area2, area1/area2);
    
function area = computeArea(P, F)
    area = 0;
    for i=1:size(F,1)
        a=P(F(i,1),1:2);
        b=P(F(i,2),1:2);
        c=P(F(i,3),1:2);
        A = sqrt(sum((a-b).^2));
        B = sqrt(sum((b-c).^2));
        C = sqrt(sum((c-a).^2));
        s = (A + B + C)/2;
        area = area + sqrt(s*(s-A)*(s-B)*(s-C));
    end
        
            