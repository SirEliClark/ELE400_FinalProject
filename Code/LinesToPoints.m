%% Hough tramsform lines to point set


function [PointsH] = LinesToPoints(lines)

Points = cell(length(lines),2);
PointsH = {}; count = 1;
for k = 1:length(lines)
    % Get points from the lines
    Points{k,1} = lines(k).point1;
    Points{k,2} = lines(k).point2;
    HorDist = abs(Points{k,1}(1)-Points{k,2}(1));
    VertDist = abs(Points{k,1}(2)-Points{k,2}(2));
    if HorDist >= VertDist
        PointsH{count,1} = Points{k,1};
        PointsH{count,2} = Points{k,2};
        count = count + 1;
    end
end



% plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%
%     % Plot beginnings and ends of lines
%     plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%     plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
%
%     % Determine the endpoints of the longest line segment
%     len = norm(lines(k).point1 - lines(k).point2);
%     if ( len > max_len)
%         max_len = len;
%         xy_long = xy;
%     end

end
