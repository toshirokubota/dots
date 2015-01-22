function [src sink] = selectSrcSink(P, src, sink, thres)
    if ~exist('src','var')
        src=[];
    end
    if ~exist('sink','var')
        sink=[];
    end
    if ~exist('thres','var') | isempty(thres)
        thres = 1;
    end
    clf;
    showPoints(P, [], [], 'b.', 'MarkerSize', 10);
    hold on;
    if ~isempty(src)
        plot(P(src,2), P(src,1), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
    end
    if ~isempty(sink)
        plot(P(sink,2), P(sink,1), 'gx', 'LineWidth', 2, 'MarkerSize', 10);
    end
    P = round(P(:,1:2));
    while(1)
        [x y b] = ginput;
        if length(x)<2
            resp2 = questdlg('You need to click at least two points.', 'Warning', 'Ok', 'quit', 'ok');
            if resp2(1)=='q'
                break;
            else
                continue;
            end
        end
        [ix iy] = interpolate(x, y);
        X = repmat(ix', [size(P,1) 1]);
        Y = repmat(iy', [size(P,1) 1]);
        X2 = repmat(P(:,2), [1 length(ix)]);
        Y2 = repmat(P(:,1), [1 length(iy)]);
        D = (X-X2).^2 + (Y-Y2).^2;
        [s t] = ind2sub(size(X), find(D<thres));
        if b(1)==1
            h1 = plot(P(s,2), P(s,1), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
        else
            h1 = plot(P(s,2), P(s,1), 'gx', 'LineWidth', 2, 'MarkerSize', 10);
        end
        resp = questdlg('Do you want to continue?', 'Question', 'yes', 'no', 'cancel', 'yes');
        if resp(1)=='c'
            delete(h1)
            continue;
        end
        if b(1)==1
            src(end+1:end+length(s),1)=s;
            sink = setdiff(sink, s);
        else
            sink(end+1:end+length(s),1)=s;
            src = setdiff(src, s);
        end
        src=unique(src);
        sink = unique(sink);
        if resp(1)=='n'
            break;
        end
    end
    hold off;
    
%interpolate points on integer grid.
function [ix iy] = interpolate(x, y)    
    ix=[];
    iy=[];
    x=round(x);
    y=round(y);
    for i=1:length(x)-1
        if abs(x(i+1)-x(i)) > abs(y(i+1)-y(i))
            jx =(min(x(i),x(i+1)):max(x(i),x(i+1)))';
            try
                jy = round(interp1([x(i+1),x(i)], [y(i+1),y(i)], jx));
            catch
                continue;
            end
            ix(end+1:end+length(jx),1)=jx;
            iy(end+1:end+length(jx),1)=jy;
        else
            jy =(min(y(i),y(i+1)):max(y(i),y(i+1)))';
            try
                jx = round(interp1([y(i+1),y(i)], [x(i+1),x(i)], jy));
            catch
                continue;
            end
            ix(end+1:end+length(jx),1)=jx;
            iy(end+1:end+length(jx),1)=jy;
        end
    end
    
