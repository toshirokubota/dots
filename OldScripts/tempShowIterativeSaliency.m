function tempShowIterativeSaliency(P)   
    first = 1;
    for i=30:30
        [P2 F2 E2 S T R X Y] = TriangulationEdgeSaliency(P, i, 0.1, 1, 0, 3);
        if first
            first = 0;
            X2 = (X-min(X(:)))/(max(X(:))-min(X(:))); %normalize
            displaySaliency(i, P2, E2, X2);
        end
        displaySaliency(i, P2, E2, Y);
        pause;
    end
    
function displaySaliency(iter, P, E, X)
    figure;
    for k=1:5
        subplot(1, 5, k);
        hold on;
        for i=1:size(E,1)
            p=P(E(i,1),:);
            q=P(E(i,2),:);
            plot([p(2) q(2)], [p(1) q(1)], 'Color', [X(i,k) 0 0], 'LineWidth', 2);
        end
        axis image;
        set(gca, 'YDir', 'reverse');    
    end
    set(gcf, 'Name', sprintf('Iteration %d', iter));
    
        