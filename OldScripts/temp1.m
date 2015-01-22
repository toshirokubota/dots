Q = shape2points('C:\Toshiro\Research\NSF2011\Summer2012\Data\Shapes\cherries.shape');
Q(:,7)=0; C{1}=Q;
[P F E S R O R2] = TriangulationCarving(C, 20, 5);
[P2 F2 F3 dmap R C1 C2 costs] = TriangulationSegmentation(P, round(max(P)+10),0, 10);

[L D Ct] = Testbed(dmap, P);
figure;
myimage(Ct);
hold on;
plot(P(:,2), P(:,1), 'ko', 'LineWidth', 2);
tempDrawTriangles2(P2, F2, 0, []);

tempIterateRemoval(P2, F3, R);

% tempSuperImposeContours(dmap, C1, C2, costs);
