function [P x] = RDConvergence(n, k)
    
    x = rand(n,1);
    p = ones(n,1)/n;
    for i=1:k
        P(:,i) = p;
        p = x.*p.*p / sum(x.*p.*p);
    end
    
    plot(1:size(P,2), max(P)-min(P));
    