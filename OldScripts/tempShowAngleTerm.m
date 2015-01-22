function A = tempShowAngleTerm(mode)
    theta = 0:.1:2*pi;
    s = repmat(theta, [length(theta) 1]);
    t = repmat(theta', [1 length(theta)]);
    df = sin(.5*(s-t));
    A=[];
    switch mode
        case {0}
            A = (1-cos(s)).*(1-cos(t))/4;
        case {1}
            A = (1-cos(s)).*(1-cos(t))./(4*(1+df.*df));
        case {2}
            A = (1-cos(s)).*(1-cos(t))./(4*(1+abs(df)));
        case {3}
            A = 1./(4*(1+df.*df));
        otherwise
            error('unsupported mode.')
            return;
    end
    
    A = A(end:-1:1,:); %reverse in Y axis.
    figure;
    myimage(A);
    axis image;
    set(gca, 'YDir', 'reverse');    

    