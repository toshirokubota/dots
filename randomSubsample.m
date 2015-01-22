function [B P]= randomSubsample(A, s)
    if ~exist('s','var') | isempty(s)
        s=2;
    end
    if length(s)==1
        s(2)=s(1);
    end
    
    if s>1
        B = repmat(A(1)*0, size(A));
        for x=1:s(1):size(A,1)
            for y=1:s(2):size(A,2)
                patch = A(x:min(size(A,1),(x+s(1)-1)), y:min(size(A,2),(y+s(2)-1)));
                j = find(patch);
                if length(j)>0
                    [x2 y2] = ind2sub(size(patch), j);
                    mx = x+round(mean(x2-1));
                    my = y+round(mean(y2-1));
                    B(mx,my) = mean(patch(j));
                end
            end
        end
    else
        B = A;
    end
    [x y] = ind2sub(size(B), find(B));
    P = [x y];
    
    
    