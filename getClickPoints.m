function S = getClickPoints(h)

    figure(h);
    S={};
    while(1)
        [x y b] = ginput;
        S{end+1} = [x y b];
        resp = questdlg('Do you want to continue?', 'Question', 'yes', 'no', 'yes');
        if resp(1)=='n' | resp(1)=='N'
            break;
        end
    end
    