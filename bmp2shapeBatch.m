function bmp2shapeBatch(letters)

    if ~exist('letters','var') | isempty(letters)
        letters = 'ABEQ';
    end
    
    for letter = letters
        bmp2shape([letter '.bmp'], [letter '.shape'], 5);
    end
    