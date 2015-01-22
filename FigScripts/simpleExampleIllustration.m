function simpleExampleIllustration()
    a = [-4 4 -7.5 7.5];
    n = 3;
    fs = 24;
    resizeFigure([], [], [1 3], 30*[a(4)-a(3) a(2)-a(1)]);
    load 'simpleExample';
    subplot(1,n,1);
    subplot('position', [0.0 0.05 0.3 0.9]);
    plot1(P0);
    setAxis(a);
    text(-1, -7.5, '(a) dots', 'FontSize', fs);

    subplot(1,n,2);
    subplot('position', [0.35 0.05 0.3 0.9]);
    plot1(P0);
    hold on;
    plot2(Pt, Et);
    setAxis(a);
    text(-1, -7.5, '(b) tree', 'FontSize', fs);
    
    subplot(1,n,3);
    subplot('position', [0.7 0.05 0.3 0.9]);
    plot1(P0);
    hold on;
%     plot2(Pt, Et);
    plot4(W, [13 16 20]);
    setAxis(a);
    text(-3, -7.5, '(c) Polygons', 'FontSize', fs);
    
    
    
function setAxis(a)
%     set(gca, 'YDir', 'reverse');    
    axis image;
    axis off;
    axis(a);

    
function plot1(P)    
    plot(P(:,2), P(:,1), 'ko', 'LineWidth', 2);

function plot2(P, E)
    eidx = E(find(E(:,3)),1:2);
    for i=1:size(eidx)
        p = P(eidx(i,1:2),:);
        plot(p(:,2), p(:,1), 'k-', 'LineWidth', 2);
    end

function plot3(W)
    for i=1:length(W)
        p = W{i};
        plot(p([1:end 1],2), p([1:end 1],1), 'k:');
    end
    
function plot4(W, sel)
    for i=1:length(W)
        p = round(100*W{i})/100;
        if size(unique(p,'rows'),1)<=3 
            continue;
        end
        if isempty(find(sel==i))
            plot(p([1:end 1],2), p([1:end 1],1), 'k-', 'LineWidth', 1);
        else
            plot(p([1:end 1],2), p([1:end 1],1), 'k-', 'LineWidth', 5);
        end
    end
    
    
    