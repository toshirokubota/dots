function fixMatFiles()
    
    files = dir('.\\*.mat');
    for i=1:length(files)
        load(files(i).name);
%         P=P0;
        j=strfind(files(i).name, '.');
%         filename=[files(i).name(1:j(1)-1) files(i).name(j(2)-1)]; 
%         save(filename, 'P');
        noise_level = 3 - str2num(files(i).name(j(1)-1));
        name=files(i).name(1:j(1)-2);
        filename = ['fixed\\' name num2str(noise_level)];
        save(filename, 'P', 'name', 'noise_level');
        
        if noise_level==1
            noise_level = 0;
            P = P(find(P(:,3)~=1),:);
            filename = ['fixed\\' name num2str(noise_level)];
            save(filename, 'P', 'name', 'noise_level');
        end        
    end
    