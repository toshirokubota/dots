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
                if ~isempty(p)
                    plot(p([1:end 1],2), p([1:end 1],1), 'g.-');
                end
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
        cm = colormap('colorcube');
        i = 1;
        done = 0;
        while done==0
            pnts = Z{i};
            N = max(pnts(:,3));
            fprintf('%d: ', i);
            sz=[];
            for j=0:N
                p = pnts(find(pnts(:,3)==j),1:2);
                fprintf('%d ', size(p,1));
                sz(j+1,:)=[size(p,1) j];
            end
            fprintf('\n');
            figure(fh);
            ls = [colors{mod(i, length(colors))+1} '-'];
            sv = sort(unique(sz(:,1)), 1, 'descend');
            h=[];
            title([num2str(i) ', ' num2str(N) ', ' num2str(length(sv))] );
            for j=1:length(sv)
                val = sv(j);
                if val < 7
                    break;
                end
                j2=find(sz(:,1)==val);
                X=[]; Y=[];
                for k=sz(j2,2)'
                    X(:,end+1)=pnts(find(pnts(:,3)==k),2);
                    Y(:,end+1)=pnts(find(pnts(:,3)==k),1);
                end
                k = mod(j, size(cm,1))+1;
                if j>=1
                    h(end+1) = patch(X, Y, cm(k,:)); %[(j+1)/(N+1) 0 0]);
%                     h(end+1) = patch(X, Y, cm(1,:)); %[(j+1)/(N+1) 0 0]);
%                 h(end+1) = fill(X, Y, cm(k,:)); %[(j+1)/(N+1) 0 0]);
                else
                    h(end+1) = patch(X, Y, 'r'); %[(j+1)/(N+1) 0 0]);
%                     for col=1:size(X,2)
%                         h(end+1) = plot(X([1:end 1],col), Y([1:end 1],col), '-', 'Color', cm(k,:), 'LineWidth', 2);
%                     end
                end
            end
%             while 1
%                 resp = input('type p, n or q: ', 's');
%                 if ~isempty(resp) && resp(1)=='p'
%                     i = i - 1;
%                     break;
%                 elseif ~isempty(resp) && resp(1)=='n'
%                     i = i + 1;
%                     break;
%                 elseif ~isempty(resp) && resp(1)=='q'
%                     done = 1;
%                 end
%             end
            pause();
            i = i + 1;
            for j=1:length(h)
                delete(h(j));
            end
        end
    end
    