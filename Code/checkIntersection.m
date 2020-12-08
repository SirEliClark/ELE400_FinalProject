%% Check Intersection
% Takes points from hough lines and eye bbox
% Check if there are lines inside the extended box

function [inside] = checkIntersection(Points, bbox)
inside = 0;
% Parameter to extend bbox down by
H_ext = 2;
% Get extedned box corners
T = bbox(2); 
B = bbox(2)+bbox(4)*H_ext;
L = bbox(1);
R = bbox(1)+bbox(3);
% TL = [bbox(1) bbox(2)];
% TR = [bbox(1)+bbox(3) bbox(2)];
% BL = [bbox(1) bbox(2)+bbox(4)*H_ext];
% BR = [bbox(1)+bbox(3) bbox(2)+bbox(4)*H_ext];
for i = 1:size(Points,1)
    x1 = Points{i,1}(1); x2 = Points{i,2}(1);
    y1 = Points{i,1}(2); y2 = Points{i,2}(2);
    % Check point 1
    if (x1 >= L && x1 <= R)
        if (y1 >= T && y1 <= B)
            inside = 1;
        end
    end
    % Check point 2
    if (x2 >= L && x2 <= R)
        if (y2 >= T && y2 <= B)
            inside = 1;
        end
    end
end

end