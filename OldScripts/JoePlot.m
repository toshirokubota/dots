function [y z] = JoePlot(D, a)
    if ~exist('D','var') | isempty(D)
        D = 384400;
    end
    if ~exist('a','var') | isempty(a)
        a = 0.009039;
    end
    
%     z=0:10000:D;
%     plot(z, 180/pi*atan(a./(1-z/D)), 'LineWidth', 2);
    z = 0:.01:1;
    y = 180/pi*2*atan((a/2)./(1-z));
    plot(z, y, 'LineWidth', 2);
    set(gca, 'FontSize', 12);
    xlabel('Displacement Ratio (dz/Z)');
    ylabel('Angle (degree)');
    set(gca, 'FontSize', 14);
    title('Angular expansion due to displacement');
    
    
    