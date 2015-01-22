function [C p] = shape2contour(shapefile, rate, boundaryOn)
%read a shape (dot) file and construct a single contour.
if ~exist('rate', 'var') | isempty(rate)
    rate = 1;
end
if ~exist('boundaryOn', 'var') | isempty(boundaryOn)
    boundaryOn = 0;
end

p = dlmread(shapefile);
p = reshape(p, [2, length(p)/2])';
p = p(1:rate:end,:);
p = p(:,2:-1:1);
C{1} = [p zeros(size(p,1),5)];

if boundaryOn
    margin = 20;
    box=[min(p(:,2:-1:1))-margin max(p(:,2:-1:1))+margin];
    box = round(box);
    h = box(4)-box(2)+1;
    w = box(3)-box(1)+1;
    left = [ones(h,1)*box(1) (box(2):box(4))' zeros(h, 5)];
    bottom = [(box(1):box(3))' ones(w,1)*box(4) zeros(w, 5)];
    right = [ones(h,1)*box(3) (box(4):-1:box(2))' zeros(h, 5)];
    top = [(box(3):-1:box(1))' ones(w,1)*box(2) zeros(w, 5)];

    C{2}=[left; bottom; right; top];
end



