function tempDrawFastMarchingTree(P, F, tr, root)

    tempDrawTriangles2(P, F);
    hold on;
    tempDrawColoredTriangles(P, F(root,:), 1, [], colormap('jet'));
    quiver(tr(:,2), tr(:,1), tr(:,4)-tr(:,2), tr(:,3)-tr(:,1), 2);
%     for i=1:size(tr,1)
%         x=tr(i,[1 3]);
%         y=tr(i,[2 4]);
%         plot(y, x, 'ro-');
%     end
    hold off;