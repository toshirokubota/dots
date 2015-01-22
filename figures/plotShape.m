function plotShape(filepath)
%Plot a shape - reproducing what is shown by the Processing program.
    [pathstr filestr extstr] = fileparts(filepath);
    try
        P = shape2points(filepath);
    catch
        return;
    end
    P = normalizePoints(P, [512, 512], [10 10]);
    P(end+1,:)=P(1,:);
    plot(P(:,2), P(:,1), 'b-', 'LineWidth', 2);
    axis([1 512 1 512]);
    axis equal;
    axis off;
    set(gca, 'YDir', 'reverse');    

    savename = [filestr '.eps'];
    print(gcf, '-deps', savename);
%     savename = [filestr '.png'];
%     print(gcf, '-dpng', savename);
    
