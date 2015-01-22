function T = tempPrintTrebles(T, NumCol, sel)

    if ~exist('sel','var')
        sel = 1:size(T,1);
    end
    if ~exist('NumCol', 'var') | isempty(NumCol)
        NumCol = 7;
    end
    
    for i=sel
        S = T{i};
        S = reshape(S, [length(S)/NumCol NumCol]);
        T{i} = S;
%         fprintf('Column %d\n', i);
%         for j=1:size(S,1)
%             fprintf('%d\t', S(j,1:3));
%             fprintf('%3.3f\n', S(j,4));
%         end
    end
        