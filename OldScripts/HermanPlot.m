function HermanPlot()
    load('Herman');
    data={EhrensteinConcave,EhrensteinConvex, EhrensteinRegular, ...
        KanizsaConcave, KanizsaConvex, KanizsaRegular,...
        SolidConcave, SolidConvex, SolidRegular};
    names={'Ehrenstein Concave','Ehrenstein Convex', 'Ehrenstein Regular', ...
        'Kanizsa Concave', 'Kanizsa Convex', 'Kanizsa Regular',...
        'Solid Concave', 'SolidConvex', 'SolidRegular'};

    n = 150:10:250;
    colormap('cool');
    for i=1:9
        subplot(3, 3, i);
%         [N X] = hist(data{i}(:), n);
%         bar(N);
%         set(h, 'facecolor', [0.5 0 0]);
        hist(data{i}(:), n);
        title(names{i});
        xlabel('gray scale');
        ylabel('count');
        axis([150 250 0 60]);
    end

% subplot(3, 3, 1);
% hist(EhrensteinConcave(:), n);
% title('Ehrenstein Concave');
% subplot(3,3,2);
% hist(EhrensteinConvex(:), n);
% title('Ehrenstein Convex');
% subplot(3,3,3);
% hist(EhrensteinRegular(:), n);
% title('Ehrenstein Regular');
% subplot(3,3,4);
% hist(KanizsaConcave(:), n);
% title('Kanizsa Concave');
% subplot(3,3,5);
% hist(KanizsaConvex(:), n);
% title('Kanizsa Convex');
% subplot(3,3,6);
% hist(KanizsaRegular(:), n);
% title('Kanizsa Regular ');
% subplot(3,3,7);
% hist(SolidConcave(:), n);
% title('Solid Concave');
% subplot(3,3,8);
% hist(SolidConvex(:), n);
% title('Solid Convex');
% subplot(3,3,9);
% hist(SolidRegular(:), n);
% title('Solid Regular');
% 
