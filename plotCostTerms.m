function plotCostTerms(T)
    
    hold on;
    color='rbgcmyk';
    for i=1:size(T,2)
        plot(double(T(:,i)), [color(i) '-']);
    end
    