function tempShowSegmentationLabelsCombined(labels, seeds, C)
%display segmentation labels obtained by TriangulationSegmentation (V2).

    im = repmat(uint32(0), size(labels,1), size(labels,2));
    for k=1:size(seeds,1)
        z = floor((k-1)/32)+1;
        b = mod(k-1,32);
        lb = squeeze(labels(:,:,z));
        jm = bitand(lb, repmat(uint32(2^b), size(lb)));
        im(find(jm)) = im(find(jm)) + 1;
    end
    myimage(im);
    hold on;
    plot(seeds(:,2), seeds(:,1), 'yx', 'MarkerSize', 15, 'LineWidth', 2);
    showContours(C, [], [], [], '-', 'LineWidth', 2, 'Color', [1 1 1]);
