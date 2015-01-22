function [p es groups] = dotAnalysisANOVA1(X, len, dispon)
    if ~exist('dispon','var') | isempty(dispon)
        dispon = 'off';
    end
    
    groups=[repmat(1, [1 len(1)]),...
        repmat(2, [1 len(2)]), repmat(3, [1 len(3)])];
    for i=1:size(X,1)
        [p(i,:) tab stats] = anova1(X(i,:), groups, dispon);
        es(i,1) = tab{2,2}/tab{4,2}; %SST/SSM
    end
    