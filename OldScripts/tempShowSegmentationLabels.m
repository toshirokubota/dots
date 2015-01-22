function tempShowSegmentationLabels(labels, seeds, C, S)
%display segmentation labels obtained by TriangulationSegmentation (V2).

    fg = (max(labels,[], 3)>0);
    for k=1:size(seeds,1)
        z = floor((k-1)/32)+1;
        b = mod(k-1,32);
        lb = squeeze(labels(:,:,z));
        clf;
        imagesc(fg); hold on;
        im = bitand(lb, repmat(uint32(2^b), size(lb)));
        myimage(im);
        hold on;
        plot(seeds(k,2), seeds(k,1), 'yx', 'MarkerSize', 15, 'LineWidth', 2);
        if exist('C','var') & isempty(C)==false
            showContours(C, [], [], [], 'r-', 'LineWidth', 2);
        end
        if exist('S','var') & isempty(S)==false
            hold on;
            plot(S(:,2), S(:,1), '-', 'Color', [1 1 1], 'LineWidth', 2);
        end
        fprintf('%d: %d %d %f\n', k, seeds(k,:));
        pause;
    end
