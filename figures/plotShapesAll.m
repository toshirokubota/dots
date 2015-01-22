function plotShapesAll(filespec)
    files = dir(filespec);
    filepath = fileparts(filespec);
    for i = 1:length(files)
        plotShape([filepath '\' files(i).name]);
    end
    