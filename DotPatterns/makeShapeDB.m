function db = makeShapeDB()
    files = dir('*0.mat');
    q = makeSquare(600, [200 200], 10);
    for i=1:length(files)
        load(files(i).name);
        if ~exist('db', 'var')
            db(1).name = 'square';
            p=0:10;
            db(1).P =makeSquare(600, [200 200], 10);
            db(2).name = 'circle';
            db(2).P = P(find(P(:,3)==2),:);
        end
        db(end+1).name = name;
        db(end).P = P(find(P(:,3)==0),:);
    end
    for i=1:length(db)
        showPoints(db(i).P, [], [], 'b.', 'MarkerSize', 14);
        title(db(i).name);
        pause;
    end
    
function s = makeSquare(len, offset, n)
    a = 0:n-1;
    b = ones(1,n);
    s1=[a' 0*b'];
    s2=[n*b' a'];
    s3=[a(end:-1:1)'+1 n*b'];
    s4=[0*b' a(end:-1:1)'+1];
    s = (len/10) * [s1; s2; s3; s4];
    s = s + repmat(offset, [size(s,1) 1]);
        