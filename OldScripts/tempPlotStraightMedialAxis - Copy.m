function tempStraightMedialAxis(P, B, X, Y, Z, em)
    clf;
    fh = gcf;
%     axis image;
    axis equal;
    set(gca, 'YDir', 'reverse');
    hold on;
    if exist('em', 'var') && ~isempty(em)
        axis([0 size(em,2) 0 size(em,1)])
    end
    if exist('B','var') && ~isempty(B)
        plot(B([1:end 1],2), B([1:end 1],1), 'k-', 'LineWidth', 2);
    end
%     plot(X(:,2),X(:,1), 'ro');
%     plot(X(:,4),X(:,3), 'bx');
%     axis image;
%     set(gca, 'YDir', 'reverse');

    if exist('P','var') && ~isempty(P)
        plot(P(:,2), P(:,1), 'k.', 'MarkerSize', 14);
    end
%     if(exist('Y','var') && ~isempty(Y))        
%         for i=1:length(Y)
%             pnts = Y{i};
%             plot(pnts([1:end 1],2), pnts([1:end 1],1), 'g-');
%         end
%     end
    if(exist('Y','var') && ~isempty(Y))        
        for i=1:length(Y)
            pnts = Y{i};
            N = max(pnts(:,3));
            for j=0:N
                p = pnts(find(pnts(:,3)==j),1:2);
                plot(p([1:end 1],2), p([1:end 1],1), 'g-');
            end
        end
    end
    
    %draw fronts
    colors={'w', 'y', 'b', 'c', 'm', 'r', 'k'}; 
    if exist('X','var') && ~isempty(X)
        for i=1:size(X,1)
            if X(i,8)>0
%             if(X(i,8)==2 || X(i,8)==3 || X(i,8)==4|| X(i,8)==5)
%             if(X(i,8)==5)
      
%                 ls = [colors{X(i,8)} '-'];
                ls = ['b-'];
                plot([X(i,2) X(i,4)], [X(i,1) X(i,3)], ls, 'LineWidth', 1);
            end
        end
    end
%     showPoints(P, [], [], '.', 'MarkerSize', 14);
    
%     if(exist('Z','var') && ~isempty(Z))
%         for i=1:length(Z)
%             title(num2str(i));
%             pnts = Z{i};
%             figure(fh);
%             ls = [colors{mod(i, length(colors))+1} '-'];
% %             h0 = plot(pnts(1,2), pnts(1,1), ls, 'MarkerSize', 18);
% %             h = plot(pnts([1:end 1],2), pnts([1:end 1],1), ls, 'LineWidth', 2);
% % %             h = plot(pnts(:,2), pnts(:,1), ls, 'MarkerSize', 18, 'LineWidth', 2);
%             patch(pnts([1:end 1],2), pnts([1:end 1],1), colors{mod(i, length(colors))+1});
%             pause();
%             figure(fh);
% %             delete(h);
% %             plot(pnts([2:end 2],2), pnts([2:end 2],1), ls, 'MarkerSize', 18, 'LineWidth', 2);
%         end
%     end

    if(exist('Z','var') && ~isempty(Z))
        cm = colormap('jet');
        cm = [1 0 0; 1 1 0; 1 0 1; 0 1 1; 0 0 0];
        for i=1:length(Z)
            pnts = Z{i};
            N = max(pnts(:,3));
            title([num2str(i) ',' num2str(N)] );
            fprintf('%d: ', i);
            sel=[];
            for j=0:N
                p = pnts(find(pnts(:,3)==j),1:2);
                fprintf('%d ', size(p,1));
                sel(j+1,:)=[size(p,1) j];
            end
            [sv si] = sort(sel(:,1)); %sort based on the size
            sel = sel(si(end:-1:1),:);
            fprintf('\n');
            figure(fh);
%             ls = [colors{mod(i, length(colors))+1} '-'];
            ls = [colors{mod(i, length(colors))+1} '-'];
            h=[];
            for j=0:N
                j2=sel(j+1,2);
                p = pnts(find(pnts(:,3)==j2),1:2);
                if size(p,1) < 5
                    break;
                end
                k = mod(j, size(cm,1))+1;
%                 h(j+1) = plot(p([1:end 1],2), p([1:end 1],1), '-', 'Color', cm(k,:), 'LineWidth', 2);
%                 h(j+1) = patch(p([1:end 1],2), p([1:end 1],1), cm(k,:)); %[(j+1)/(N+1) 0 0]);
                h(end+1) = fill(p([1:end 1],2), p([1:end 1],1), cm(k,:)); %[(j+1)/(N+1) 0 0]);
            end
            pause();
            for j=1:length(h)
                delete(h(j));
            end
        end
    end
    