function tempSummarizeResults(results, db)
%RESULTS are obtained by running batch_straight_polygon_grouping.
%01/09/2015

exc=[];
for i=1:length(db)
    if strcmp(db(i).name, 'circle')==1 || strcmp(db(i).name, 'square')==1
        exc(end+1)=i;
    end
end

for i=1:length(results)
    ranks = results(i).r;
    fits = results(i).f;
    name = results(i).name;
    [fits, j] = sort(fits);
    ranks = ranks(j);
    for k=1:length(exc)
        j2 = find(ranks==exc(k));
        ranks(j2)=[];
        fits(j2)=[];
    end
    if isempty(ranks)
        fprintf('%s\tNA\tNA\n', name);
    else
        fprintf('%s\t%s\t%f\n', name, db(ranks(1)).name, fits(1));
    end
%     for k=1:min(5,length(ranks))
%         fprintf('\t%d %s %f\n', k, db(ranks(k)).name, fits(k));
%     end
end

% for i=1:length(results)
%     fprintf('%s\n', results(i).filename);
%     for j=1:length(results(i).G)
%         rank = results(i).r(j,1);
%         fit = results(i).f(j,1);
%         fprintf('%d %s %f\n', j, db(rank).name, fit);
%     end
% end
