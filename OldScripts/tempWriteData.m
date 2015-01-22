function tempWriteData()
% combine all matrices in group.mat and write them to a text file,
%which can be loaded into xls or spss.

load 'grouping.mat';

fid = fopen('grouping_raw.txt', 'wt');
for i=1:size(points,2)
    for j=1:size(points,1)
        fprintf(fid, '%s\t%d\t%d\t%d\n', shape_names{j}, j, points(j,i), 1);
    end
end
for i=1:size(allTriangles,2)
    for j=1:size(allTriangles,1)
        fprintf(fid, '%s\t%d\t%d\t%d\n', shape_names{j}, j, allTriangles(j,i), 2);
    end
end
for i=1:size(triangles2,2)
    for j=1:size(triangles2,1)
        fprintf(fid, '%s\t%d\t%d\t%d\n', shape_names{j}, j, triangles2(j,i), 3);
    end
end
fclose(fid);

