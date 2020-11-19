function [points,chainLen] = Hysterisis(I_NM,t_l,t_h,Eo)

[rows,cols] = size(I_NM);
visited = zeros(rows,cols);
points = [];
chainLen = [];
for r = 2:rows-1
    for c = 2:cols-1
        i = 0;
        j = 0;
        counter = 0;
        if((I_NM(r,c) > t_h) && (visited(r,c) == 0))
            visited(r,c) = 1;
            if(Eo(r,c) == 0)
                while((I_NM(r-i,c) > t_l) && (r-i > 1))
                    visited(r-i,c) = 1;
                    points = [points;(r-i),c];
                    counter = counter+1;
                    i = i+1;
                end   
                while((I_NM(r+j,c) > t_l) && (r+j < rows-1))
                    visited(r+j,c) = 1;
                    points = [points;(r+j),c];
                    counter = counter+1;
                    j = j+1;
                end 
                chainLen = [chainLen;counter];
                
            elseif(Eo(r,c) == 45)
                while((I_NM(r-i,c+i) > t_l) && (r-i > 1) && (c +i < cols-2))
                    visited(r-i,c+i) = 1;
                    points = [points;(r-i),(c+i)];
                    counter = counter+1;
                    i = i+1;
                end   
                while((I_NM(r+j,c-j) > t_l) && (r+j < rows-1) && (c-j) > 2)
                    visited(r+j,c) = 1;
                    points = [points;(r+j),(c-j)];
                    counter = counter+1;
                    j = j+1;
                end 
                chainLen = [chainLen;counter];
                
            elseif(Eo(r,c) == 90)
                while((I_NM(r,c-i) > t_l) && (c-i > 1))
                    visited(r,c-i) = 1;
                    points = [points;r,(c-i)];
                    counter = counter+1;
                    i = i+1;
                end   
                while((I_NM(r,c+j) > t_l) && (c+j < cols-1))
                    visited(r,c+j) = 1;
                    points = [points;r,(c+j)];
                    counter = counter+1;
                    j = j+1;
                end 
                chainLen = [chainLen;counter];
            elseif(Eo(r,c) == 135)
                while((I_NM(r-i,c-i) > t_l) && (r-i > 1) && (c - i > 2))
                    visited(r-i,c-i) = 1;
                    points = [points;(r-i),(c-i)];
                    counter = counter+1;
                    i = i+1;
                end   
                while((I_NM(r+j,c+j) > t_l) && (r+j < rows-1) && (c+j) < cols- 2)
                    visited(r+j,c) = 1;
                    points = [points;(r+j),(c+j)];
                    counter = counter+1;
                    j = j+1;
                end 
                chainLen = [chainLen;counter];
            end 
        end
        visited(r,c) = 1;

    end
end


end

