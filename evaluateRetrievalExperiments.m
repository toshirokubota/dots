function N=evaluateRetrievalExperiments(names, X)
%evaluate results obtained by dotRetrievalExperiments.
%Run dotRetrievalExperiments with
%[X Z names] =
%dotRetrievalExperiments('C:\Toshiro\Research\NSF2011\Summer2012\Data\Shapes\*.shape');
%Then, run
%N=evaluateRetrievalExperiments(names, X);
%N has an entry of K after which every retrieval was successful.
    N=zeros(length(X),1);
    thres = 3;
    for i=1:length(X)
        j = strmatch(X(i).name, names, 'exact');
        if isempty(j)
            error(['Cannot find ' X(i).name 'in names.']);
        end
        
        s = X(i).scores(:,j);
        r = min(X(i).scores(:,[1:(j-1) (j+1):end]),[],2);
        N(i)=nan;
        for k=1:size(s,1)
            if s(k)<=1 & r(k)>thres
                N(i)=X(i).numps(k);
                break;
            end
        end
%         fprintf('%s\n', X(i).name);
%         fprintf('%3.3f ', s);
%         fprintf('\n');
%         k = find(s==1.0);%find successful match
%         
%         if length(k)>0
%             N(i) = X(i).numps(k(1));
%         else
%             N(i) = nan;
%         end
        
    end
    