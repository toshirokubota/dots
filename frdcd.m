function z = frdcd(P)
%The function computes the Fourier transform of the centroid distance of a
%shape. P is a N by 2 points that are assumed to be CLOSED.
%Z is a normalized absolute values of the Fourier coefficients. Since the
%centroid distance is real, only the half of the coefficients are returned.
%

    mv = mean(P);
    Q = P - repmat(mv, [size(P,1) 1]); %subtract centroid
    r = sqrt(Q(:,1).^2+Q(:,2).^2); %get the centroid distance
    x = fft(r);
    z = abs(x) ./x(1); %normalize
    z = z(2:int32(size(P,1)/2)); %return N/2 coefficients.
    
    