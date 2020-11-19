function [I_NM,Eo_new] = NonMaxSupression(Es,Eo)


[rows, cols] = size(Eo); % Assumes Es and Eo are the same size

for r = 1:rows
    for c = 1:cols
        if(Eo(r,c) < 0)
            Eo(r,c) = Eo(r,c) + 360;
        end
    end
end

Eo_new = zeros(rows,cols);

for r = 1:rows 
    for c = 1:cols
        if((Eo(r,c) >= 0 && Eo(r,c) < 22.5) || (Eo(r,c) >= 157.5 && Eo(r,c) < 202.5) || (Eo(r,c) >= 337.5 && Eo(r,c) < 360))
            Eo_new(r,c) = 0;
        elseif((Eo(r,c) >= 22.5 && Eo(r,c) < 67.5) || (Eo(r,c) >= 202.5 && Eo(r,c) < 247.5))
            Eo_new(r,c) = 45;
        elseif((Eo(r,c) >= 67.5 && Eo(r,c) < 112.5) || (Eo(r,c) >= 247.5 && Eo(r,c) < 292.5))
            Eo_new(r,c) = 90;
        elseif((Eo(r,c) >= 112.5 && Eo(r,c) < 157.5) || (Eo(r,c) >= 292.5 && Eo(r,c) < 337.5))
            Eo_new(r,c) = 135;
        end
    end
end

I_NM = Es;
for r = 2:(rows-1) % Must set the two not chosen to 0
    for c = 2:(cols-1)  % The 2 and -1 are to make sure nothing is accessed out of index 
        if(Eo_new(r,c) == 0)
            if(Es(r,c) < Es(r,c-1) || Es(r,c) < Es(r,c+1))
                I_NM(r,c) = 0;
            end
        elseif(Eo_new(r,c) == 45)
            if(Es(r,c) < Es(r+1,c-1) || Es(r,c) < Es(r-1,c+1))
               I_NM(r,c) = 0;
            end
        elseif(Eo_new(r,c) == 90)
            if(Es(r,c) < Es(r-1,c) || Es(r,c) < Es(r+1,c))
                I_NM(r,c) = 0;
            end
     
        elseif(Eo_new(r,c) == 135)
            if(Es(r,c) < Es(r-1,c-1) || Es(r,c) < Es(r+1,c+1))
                I_NM(r,c) = 0;
            end
        end
    end
end


end

