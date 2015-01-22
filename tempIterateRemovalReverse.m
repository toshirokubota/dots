function tempIterateRemovalReverse(P, T, R, V, endp, pauseT)
%this script replay the process of triangle removal in the reverse order.
%this was intended to aid debugging of Triangulationcurving.
%Run
%[P F E S R O R2] = TriangulationCurving(C, numpoints);
%Then, do
%tempIterateRemoval(P, O, R2);
%

    if ~exist('V','var')
        V=[];
    end
    if ~exist('endp', 'var') | isempty(endp)
        endp = [1 size(R,1)];
    elseif length(endp)==1
        endp(2) = size(R,1);
    end
    if ~exist('pauseT', 'var') | isempty(pauseT)
        pauseT = 0;
    end
    h = figure;
    hold on;
    R = R(end:-1:1,:); %reverse the order
    %plot(P(:,2), P(:,1), '.', 'MarkerSize', 30);
%     text(double(P(:,2)), double(P(:,1))+3, num2str((1:size(P,1))'));
    for i=1:size(T,1)
        t = T(i,1:3);
        Q = P([t(:)' t(1)], [1 2]);
        plot(Q(:,2), Q(:,1), 'b-', 'LineWidth', 1);
    end
    axis image;
    set(gca, 'YDir', 'reverse');    
    for i=1:endp(1)-1
        t = R(i,1:3);
        Q = P([t(:)' t(1)], [1 2]);
        plot(Q(:,2), Q(:,1), 'r-', 'LineWidth', 2);
    end
    fprintf('Hit return to intiate removal.');
    pause;
    for i=endp(1):endp(2)
        if pauseT>0
            pause(pauseT);
        else
            pause();
        end
        t = R(i,1:3); %T(R(i),1:3);
        Q = P([t(:)' t(1)], [1 2]);
        figure(h);
        plot(Q(:,2), Q(:,1), 'g-', 'LineWidth', 2);
        if i>1
            t = R(i-1,1:3); %T(R(i-1),1:3);
            Q = P([t(:)' t(1)], [1 2]);
            plot(Q(:,2), Q(:,1), 'r-', 'LineWidth', 2);
        end
        if size(V,1)>=i
            title(sprintf('%d: %f', i, V(i)));
        else
            title(num2str(i))
        end
    end
    hold off;
    
        