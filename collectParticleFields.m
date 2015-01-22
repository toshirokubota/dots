function F = collectParticleFields(P, fields)
    F=[];
    for i=1:length(P)
        f=[];
        for j=1:length(fields)
            s = getfield(P(i), fields{j});
            f(end+1:end+length(s)) = s;
        end
        F(end+1,:)=f;
    end
    
    