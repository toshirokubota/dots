function dolphine_with_dots(shape)
if ~exist('shape','var') | isempty(shape)
    shape = 'dolphin';
end
addpath('..');
folder = 'C:\Users\Kubota\Documents\MaTLAB\Dots\shapeWithNoise\';
P{3} = dlmread([folder shape '.shape_0_dots.txt']);
% P{3} = dlmread([folder shape '.shape_1_dots.txt']);
P{2} = dlmread([folder shape '.shape_2_dots.txt']);

P{1} = P{2}(find(P{2}(:,3)==0 | P{2}(:,3)==2),:);
a=[min(P{2}(:,1))-10 max(P{2}(:,1))+10 min(P{2}(:,2))-10 max(P{2}(:,2))+10];

rows=1; %# of rows
cols=3; %# of columns
delx = 0.05;
dely = 0.05
w = 0.3;
h = 0.9;
sc=3;

clf;
resizeFigure(gcf, [0 0 sc*100*cols sc*100*rows]);
ir = 1;
labels={'(a)', '(b)', '(c)', '(d)'};
for ic=1:cols
    ofx=(w+delx)*(ic-1);
    ofy=dely;
%     subplot(rows,cols,(ir-1)*cols+ic);
    subplot(1,cols,ic);
    subplot('position', [ofx ofy w h]);
    plot(P{ic}(:,2), P{ic}(:,1), 'k.', 'MarkerSize', 8);
%     xlabel(labels{ic});
    text((a(2)+a(1))/2, a(4)-100, labels{ic}, 'FontSize', 24, ...
        'HorizontalAlignment', 'Center');
    set(gca, 'YDir', 'reverse'); 
    axis(a);
    axis image; axis off;
    fprintf('%f %f %f %f\n', ofx, ofy, w, h);
end

% subplot(1,4,2);
% plot(P2(:,2), P2(:,1), 'k.', 'MarkerSize', 12);
% set(gca, 'YDir', 'reverse');    
% axis image; axis off;
% 
% subplot(1,4,3);
% plot(P1(:,2), P1(:,1), 'k.', 'MarkerSize', 12);
% set(gca, 'YDir', 'reverse');    
% axis image; axis off;
% 
% subplot(1,4,4);
% plot(P0(:,2), P0(:,1), 'k.', 'MarkerSize', 12);
% set(gca, 'YDir', 'reverse');    
% axis image; axis off;
% 
