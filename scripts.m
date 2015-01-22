% %BRIGHTNESS CONTRAST (MODULE I)
load('ContrastData');
EhrensteinConvexDiff = RegularEhrensteinConvex - RandomEhrensteinConvex;
EhrensteinConcaveDiff = RegularEhrensteinConvex - RandomEhrensteinConcave;
KanizsaConvexDiff = RegularKanizsaConvex - RandomKanizsaConvex;
KanizsaConcaveDiff = RegularKanizsaConvex - RandomKanizsaConcave;
ModalConvexDiff = RegularModalConvex - RandomModalConvex;
ModalConcaveDiff = RegularModalConvex - RandomModalConcave;

%check if the differences are statistically significant
fprintf('Modal Convex:\n');
for i=1:size(ModalConvexDiff,1)
    [h p] = ttest(ModalConvexDiff(i,:));
    fprintf('p = %f\n', p);
end
fprintf('Modal Concave:\n');
for i=1:size(ModalConcaveDiff,1)
    [h p] = ttest(ModalConcaveDiff(i,:));
    fprintf('p = %f\n', p);
end
fprintf('Ehrenstein Convex:\n');
for i=1:size(EhrensteinConvexDiff,1)
    [h p] = ttest(EhrensteinConvexDiff(i,:));
    fprintf('p = %f\n', p);
end
fprintf('Ehrenstein Concave:\n');
for i=1:size(EhrensteinConcaveDiff,1)
    [h p] = ttest(EhrensteinConcaveDiff(i,:));
    fprintf('p = %f\n', p);
end
fprintf('Kanizsa Convex:\n');
for i=1:size(KanizsaConvexDiff,1)
    [h p] = ttest(KanizsaConvexDiff(i,:));
    fprintf('p = %f\n', p);
end
fprintf('Kanizsa Concave:\n');
for i=1:size(KanizsaConcaveDiff,1)
    [h p] = ttest(KanizsaConcaveDiff(i,:));
    fprintf('p = %f\n', p);
end

%run two population t-test - using Modal shapes as the control group
fprintf('Ehrenstein Convex:\n');
for i=1:size(EhrensteinConvexDiff,1)
    [h p] = ttest2(ModalConcaveDiff(i,:), EhrensteinConvexDiff(i,:));
    fprintf('p = %f\n', p);
end
fprintf('Ehrenstein Concave:\n');
for i=1:size(EhrensteinConcaveDiff,1)
    [h p] = ttest2(ModalConvexDiff(i,:), EhrensteinConcaveDiff(i,:));
    fprintf('p = %f\n', p);
end
fprintf('Kanizsa Convex:\n');
for i=1:size(KanizsaConvexDiff,1)
    [h p] = ttest2(ModalConcaveDiff(i,:), KanizsaConvexDiff(i,:));
    fprintf('p = %f\n', p);
end
fprintf('Kanizsa Concave:\n');
for i=1:size(KanizsaConcaveDiff,1)
    [h p] = ttest2(ModalConvexDiff(i,:), KanizsaConcaveDiff(i,:));
    fprintf('p = %f\n', p);
end

%plot the distribution of contrasts
n = 150:10:260;
a = [150 250 0 60];
subplot(3, 3, 1); hist(RegularModalConvex(:), n); title('Modal Regular'); xlabel('gray scale'); ylabel('count'); axis(a);
subplot(3, 3, 2); hist(RandomModalConvex(:), n); title('Modal Random Convex'); xlabel('gray scale'); ylabel('count'); axis(a);
subplot(3, 3, 3); hist(RandomModalConcave(:), n); title('Modal Random Concave'); xlabel('gray scale'); ylabel('count'); axis(a);
subplot(3, 3, 4); hist(RegularKanizsaConvex(:), n); title('Kanzsa Regular'); xlabel('gray scale'); ylabel('count'); axis(a);
subplot(3, 3, 5); hist(RandomKanizsaConvex(:), n); title('Kanzsa Random Convex'); xlabel('gray scale'); ylabel('count'); axis(a);
subplot(3, 3, 6); hist(RandomKanizsaConcave(:), n); title('Kanzsa Random Concave'); xlabel('gray scale'); ylabel('count'); axis(a);
subplot(3, 3, 7); hist(RegularEhrensteinConvex(:), n); title('Ehrehstein Regular'); xlabel('gray scale'); ylabel('count'); axis(a);
subplot(3, 3, 8); hist(RandomEhrensteinConvex(:), n); title('Ehrehstein Random Convex'); xlabel('gray scale'); ylabel('count'); axis(a);
subplot(3, 3, 9); hist(RandomEhrensteinConcave(:), n); title('Ehrehstein Random Concave'); xlabel('gray scale'); ylabel('count'); axis(a);

%plot the distribution of differences
n = -30:5:30;
a = [-30 30 0 60];
subplot(3, 2, 1); hist(ModalConvexDiff(:), n); title('Modal Convex'); xlabel('gray scale diff'); ylabel('count'); axis(a);
subplot(3, 2, 2); hist(ModalConcaveDiff(:), n); title('Modal Concave'); xlabel('gray scale diff'); ylabel('count'); axis(a);
subplot(3, 2, 3); hist(KanizsaConvexDiff(:), n); title('Kanizsa Convex'); xlabel('gray scale diff'); ylabel('count'); axis(a);
subplot(3, 2, 4); hist(KanizsaConcaveDiff(:), n); title('Kanizsa Concave'); xlabel('gray scale diff'); ylabel('count'); axis(a);
subplot(3, 2, 5); hist(EhrensteinConvexDiff(:), n); title('Ehrenstein Convex'); xlabel('gray scale diff'); ylabel('count'); axis(a);
subplot(3, 2, 6); hist(EhrensteinConcaveDiff(:), n); title('Ehrenstein Concave'); xlabel('gray scale diff'); ylabel('count'); axis(a);


% %GROPUING (MODULE III)
muPoints=mean(points,2)
muTriangles=mean(triangles,2)
muAllTriangles=mean(allTriangles, 2)
muAll=mean([points triangles allTriangles], 2)
[sv si] = sort(muAll);
plot(1:20, muPoints(si), 'r.-', 1:20, muTriangles(si), 'g.-', 1:20, muAllTriangles(si), 'b.-');
[sv si] = sort(muPoints);
plot(1:20, muPoints(si), 'r.-', 1:20, muTriangles(si), 'g.-', 1:20, muAllTriangles(si), 'b.-');
corr([muPoints muTriangles muAllTriangles]);

%ANOVA1 (combining all shapes)
load 'grouping';
X=[points(:)' triangles(:)' triangles2(:)'];
len=[length(points(:)), length(triangles(:)), length(triangles2(:))];
dotAnalysisANOVA1(X, len, 1);

%ANOVA1 (running separate ANOVA on each shape)
load 'grouping';
X=[points triangles triangles2];
len=[size(points,2), size(triangles,2), size(triangles2,2)];
[p es] = dotAnalysisANOVA1(X, len);

%Plot of shape extraction performance
%These data are taken from DotGroupingComputation.xlsx
s=[0.8639247	0.86631095	0.8864965	0.89134865	0.9132433	0.9178101	0.9265999	0.94802035	0.95135975	0.9682452	0.9562444	0.9709496	0.9767242	0.9745764	0.9849439	0.9799875	0.9796189	0.98544745
0.198831162	0.18243635	0.172880847	0.153501832	0.124160744	0.10900258	0.121146623	0.08127558	0.084444682	0.057390219	0.080126255	0.053002017	0.047197123	0.055263089	0.032317995	0.044782247	0.039489575	0.031857451
0.044459999	0.040794008	0.038657333	0.034324053	0.027763186	0.024373718	0.027089208	0.018173772	0.018882405	0.012832843	0.017916775	0.011851611	0.010553598	0.012357202	0.007226523	0.010013615	0.008830137	0.007123543
];
c=[0.73431035	0.7731411	0.78526605	0.822542	0.85002665	0.86168435	0.8953485	0.89604365	0.9072074	0.9101217	0.9191892	0.9261253	0.92989435	0.9356485	0.93918285	0.943008	0.94723195	0.95038955
0.183967424	0.177406082	0.19739099	0.182347816	0.163762628	0.16238768	0.128740686	0.130757191	0.125200421	0.120004451	0.106133053	0.10641989	0.104776036	0.093669046	0.092600451	0.0884142	0.077182568	0.076422747
0.041136367	0.039669206	0.044137967	0.040774211	0.036618437	0.036310989	0.028787293	0.029238197	0.027995665	0.026833811	0.023732072	0.023796211	0.023428634	0.020945035	0.02070609	0.019770016	0.017258547	0.017088646
];

errorbar(x, s(1,:), s(3,:), s(3,:), 'r-', 'LineWidth', 2);
hold on
errorbar(x, c(1,:), c(3,:), c(3,:), 'b--', 'LineWidth', 2);
legend('surface based', 'contour based');
axis([30, 200, 0.5, 1]);
xlabel('K', 'fontsize', 14);
ylabel('Performance Score', 'fontsize', 14);
set(gca, 'FontSize', 14);
hold off;

%making plots for tiger example
em2 = imread('tiger_em.png');
em2 = em2(:,:,1);
j=find(em2);
[y x] = ind2sub(size(em2), j);
Q = [y, x];
figure; tempDrawPoints(Q); axis off;
[P F E S R O R2] = TriangulationCurvingV3(Q, [], inf);
figure; tempDrawTriangles2(P, F); axis off;
[P F E S R O R2] = TriangulationCurvingV3(Q, [], 5);
figure; tempDrawTriangles2(P, F); axis off;
%making similar plots for kanizsa-triangle example
load('C:\Users\kubota\Documents\MATLAB\dots\kanizsa-triangle.mat')
j=find(em);
[y x] = ind2sub(size(em), j);
Q = [y, x];
figure; tempDrawPoints(Q); axis off;
[P F E S R O R2] = TriangulationCurvingV3(Q, [], inf);
figure; tempDrawTriangles2(P, F); axis off;
[P F E S R O R2] = TriangulationCurvingV3(Q, [], 5);
figure; tempDrawTriangles2(P, F); axis off;

%Strange effect
%When I see an local maximum image with contours in black superimposed, I
%see local maximum dots floating. 
%Try
load 'C:\Users\kubota\Documents\MATLAB\Fillingin\cvpr2012\BSDSTest\108005.mat';
[P F S dmap lmap tmap labels seeds C] = tempSegmentationFromTriangulation(em);
ll = zeros(size(dmap));
ll(sub2ind(size(ll), lmap(:,1), lmap(:,2)))=1;
myimage(ll);
showContours(C, [], [], [], 'r-', 'LineWidth', 2, 'Color', [0 0 0]);
%It does not work when the color of contours is white...
