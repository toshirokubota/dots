function tempDrawCarvedFaceBranch(P, F, T)
    tempDrawTriangles2(P,F, [], [], 'Color', [0 0 0]);
    hold on;
    
    colors=[1 0 0; 0 1 0; 0 0 1; ...
        1 1 0; 1 0 1; 0 0 1; .5 .5 .5;...
        1 .5 .5; .5 1 .5; .5 .5 1;...
        1 .25 .5; .25 1 .5; .5 .25 1; 0 0 0;...
        1 .5 .25; .5 1 .25; .25 .5 1; ...
        0.5 0 0; 0 0.5 0; 0 0 0.5;
        0.5 0.5 0; 0.5 0 0.5; 0 0.5 0.5;...
        0.25 0 0; 0 0.25 0; 0 0 0.25;
        0.25 0.25 0; 0.25 0 0.25; 0 0.25 0.25;...
        ];
    count = 1;
    for i=1:size(T,1)
        if T(i,2)==0 %root
            k=[];
            next=i;
            iter=0;
            while length(next)>0
                k(end+1:end+length(next))=next;
                next2=T(next,3:5);
                next2=next2(:);
                next2(find(next2==0))=[];
                next = next2;
                iter = iter+1;
            end
            fprintf('%d: niter=%d. Hit return.\n', i, iter);        
            pause;
            sel = T(k,1)';
            color = colors(mod(count-1, size(colors,1))+1,:);
            drawTrianglesAnimation(P, F, sel, 'Color', color, 'LineWidth', 2);
            count = count + 1;
        end
    end
    hold off;
    
function drawTrianglesAnimation(P, T, sel, varargin)
%draw edges returned from TriangulationSaliency.
    P = double(P);
    for i=sel
        t = T(i,1:3);
        Q = P([t(:)' t(1)], [1 2]);
        plot(Q(:,2), Q(:,1), varargin{:});
%         pause(0.2);
    end
    
    