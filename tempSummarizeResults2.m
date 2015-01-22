function tempSummarizeResults2(results, db)
%RESULTS are obtained by running batch_straight_polygon_grouping.
%01/09/2015

for i=1:length(results)
    result = results(i);
    clf;
    showPoints(result.P, [], [], 'b.', 'MarkerSize', 14);
    hold on;
    for j=1:length(result.G)
        p = result.G{j};
        h = plot(p([1:end 1],2), p([1:end 1],1), 'g-', 'LineWidth', 2);
        r = result.r(j,1);
        title(sprintf('%s %s %3.3f',...
            result.name, db(r).name, result.f(j,1)));
        fprintf('hit Enter');
        pause();
        fprintf(' continuing...\n');
        delete(h);
    end
end



% exc=[];
% for i=1:length(db)
%     j=strfind(db(i).name, '.shape');
%     name = db(i).name(1:j-1);
%     if strcmp(name, 'circle')==1 || strcmp(name, 'square')==1
%         exc(end+1)=i;
%     end
%     names{i}=name;
% end
% for i=1:length(results)
%     name = results(i).filename;
%     dbid=0;
%     if ~isempty(strfind(name, 'circle'))
%         continue;
%     elseif ~isempty(strfind(name, 'square'))
%         continue;
%     else
%         for j=1:length(db)
%             if ~isempty(strfind(name, names{j}))
%                 dbid = j;
%                 break;
%             end
%         end
%     end
%     
% %     fprintf('%s\n', results(i).filename);
%     [fits j] = sort(results(i).f(:,1));
%     ranks = results(i).r(j,1);
%     k = 1:length(ranks); %find(ranks~=exc(1) & ranks ~=exc(2));
%     k2 = find(ranks==dbid);
%     id = ranks(k(1));
%     if isempty(k2)
%         fprintf('%s: %s %f(%d) NA(NA)\n', ...
%             results(i).filename, db(id).name, ...
%             fits(k(1)), k(1));
% %         fprintf('%f, NA\n',...
% %             getFitness(results(i).P, results(i).G{k(1)}));
%     else
%         fprintf('%s: %s %f(%d) %f(%d)\n', ...
%             results(i).filename, db(id).name, ...
%             fits(k(1)), k(1),...
%             fits(k2(1)), k2(1));
% %         fprintf('%f, %f\n',...
% %             getFitness(results(i).P, results(i).G{k(1)}), ...
% %             getFitness(results(i).P, results(i).G{k2(1)}));
%     end
% %     showSelected(results(i).P, results(i).G, k(1), k2(1));
% %     fprintf('hit Return\n');
% %     pause;
% end

function showSelected(P, G, i, j)
    showPoints(P, [], [], 'go');
    p = G{i};
    q = G{j};
    hold on;
    plot(p([1:end 1],2), p([1:end 1],1), 'b-', ...
        q([1:end 1],2), q([1:end 1],1), 'r-', 'LineWidth', 2);
    hold off;


function fit = getFitness(P, Q)
    area = OverlapArea(P(:,1:2), Q(:,1:2));
    fit = 1.0 - area(3)/(area(1)+area(2)-area(3));
