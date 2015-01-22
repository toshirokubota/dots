function BaumEagon(N, K)
% experiment Baum-Eagon iteration with a random synthetic data.
    
    %generate random symmetirical weights
    W = zeros(N,N,K);
    for i=1:K
        w = rand(N);
        w = (w + w')/2;
%         w = w - diag(diag(w)); %remove diagonals.
        W(:,:,i) = w;
    end
    F = rand(N,K);
    P = F ./ repmat(sum(F,2), [1, K]); %normalize
    iter = 100;
    for i=1:iter
        fprintf('%d\t%f\n', i, sum(F(:)));
        G = zeros(N,K);
        for j=1:K
            g = W(:,:,j) * (P(:,j));
            G(:,j) = g';
        end
        F = G;
        S = repmat(sum(F.*P,2), [1 K]);
        P = F.*P ./ S;
    end
    fprintf('%d\t%f\n', iter, sum(F(:)));
        
    
