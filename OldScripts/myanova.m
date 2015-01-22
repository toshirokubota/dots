function myanova(x, grp)

    m = mean(x);
    mv=[];
    er=[];
    n=[];
    for g=unique(grp)
        j=grp==g;
        mv(end+1)=mean(x(j));
        er(j)=x(j)-mv(end);
        n(end+1)=sum(j);
    end
    
    sst = sum((x-m).^2);
    sse = sum(er.*er);
    ssm = sum(n.*(mv-m).^2);
    fprintf('%f, %f, %f\n', ssm, sse, sst);
    
    