%% Acuracy test
%

function [Acc, MaskDect, DectBinary] = test_accuracy()
% Get Mask Data for Images
MaskReal = xlsread('CroppedSetMaskorNot.xlsx');
MaskReal = MaskReal(:,1);
MaskDect = zeros(size(MaskReal));
% Move to folder containing images
cd ..; cd NewCropped;
Ifiles = dir();
numI = size(Ifiles,1);
ColorCount = 1;
% Loop through each image
for i = 3:numI
    currI = Ifiles(i).name;
    I = imread(currI);
    % Move to code folder to run functions
    cd ..; cd Code;
    % Dectect edges and get hough transform lines
    lines = edge_detection_Final(I);
    % Get hough lines at not steep angles
    Points = LinesToPoints(lines);
    % Get eye/face bounding boxes
    [EyeSmallBox, EyeBigBox, FaceBox, EyeBox, found, Med, Av] = feature_detection(I);
    if Med ~= zeros(2,3) 
        MedColor(ColorCount) = norm(Med(1,:)-Med(2,:));
        AvColor(ColorCount) = norm(Av(1,:)-Av(2,:));
        ColorCount = ColorCount+1;
    end
    % Hough lines and bounding boxes
    
     figure;
%     faceImage = insertObjectAnnotation(I,'rectangle',[FaceBox;EyeSmallBox;EyeBigBox;EyeBox; MouthBox; NoseBox],'ROI');
    imshow(I);
        hold on
        max_len = 0;
        for k = 1:length(lines)
            xy = [lines(k).point1; lines(k).point2];
            plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
            % Plot beginnings and ends of lines
            plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
            plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
            % Determine the endpoints of the longest line segment
            len = norm(lines(k).point1 - lines(k).point2);
            if ( len > max_len)
                max_len = len;
                xy_long = xy;
            end
        end
        plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
        title("Hough and ROI's");
        hold off
    
    % Check if BigEyePair is found
    if found(2)
        MaskDect(i-2) = checkIntersection(Points, EyeBigBox);
%         if not(MaskDect(i-2))
%             Idown = I(EyeBigBox(2):end,EyeBigBox(1):EyeBigBox(1)+EyeBigBox(3),:);
%             lines = edge_detection_Final(Idown);
%             % figure; imshow(Idown);
%             Points = LinesToPoints(lines);
%             % Adjust points to real image
%             PointsAdj = cell(size(Points));
%             for k = 1:size(Points,1)
%                 PointsAdj{k,1}(1) = Points{k,1}(1)+EyeBigBox(1);
%                 PointsAdj{k,2}(1) = Points{k,2}(1)+EyeBigBox(1);
%                 PointsAdj{k,1}(2) = Points{k,1}(2)+EyeBigBox(2);
%                 PointsAdj{k,2}(2) = Points{k,2}(2)+EyeBigBox(2);
%             end
%             MaskDect(i-2) = checkIntersection(PointsAdj, EyeBigBox);
%             figure;
%             faceImage = insertObjectAnnotation(I,'rectangle',EyeBigBox,'EyeBig');
%             imshow(faceImage);
%             hold on
%             max_len = 0;
%             for k = 1:length(lines)
%                 xy = [lines(k).point1; lines(k).point2];
%                 plot(xy(:,1)+EyeBigBox(1),xy(:,2)+EyeBigBox(2),'LineWidth',2,'Color','green');
%                 
%                 % Plot beginnings and ends of lines
%                 plot(xy(1,1)+EyeBigBox(1),xy(1,2)+EyeBigBox(2),'x','LineWidth',2,'Color','yellow');
%                 plot(xy(2,1)+EyeBigBox(1),xy(2,2)+EyeBigBox(2),'x','LineWidth',2,'Color','red');
%                 
%                 % Determine the endpoints of the longest line segment
%                 len = norm(lines(k).point1 - lines(k).point2);
%                 if ( len > max_len)
%                     max_len = len;
%                     xy_long = xy;
%                 end
%             end
%             plot(xy_long(:,1)+EyeBigBox(1),xy_long(:,2)+EyeBigBox(2),'LineWidth',2,'Color','cyan');
%             title("Hough and ROI's");
%             hold off
%         end
        % Check if SmallEyePair is found
    elseif found(1)
        MaskDect(i-2) = checkIntersection(Points, EyeSmallBox);
%         if not(MaskDect(i-2))
%             Idown = I(EyeSmallBox(2):end,EyeSmallBox(1):EyeSmallBox(1)+EyeSmallBox(3),:);
%             lines = edge_detection_Final(Idown);
%             % figure; imshow(Idown);
%             Points = LinesToPoints(lines);PointsAdj = cell(size(Points));
%             for k = 1:size(Points,1)
%                 PointsAdj{k,1}(1) = Points{k,1}(1)+EyeSmallBox(1);
%                 PointsAdj{k,2}(1) = Points{k,2}(1)+EyeSmallBox(1);
%                 PointsAdj{k,1}(2) = Points{k,1}(2)+EyeSmallBox(2);
%                 PointsAdj{k,2}(2) = Points{k,2}(2)+EyeSmallBox(2);
%             end
%             MaskDect(i-2) = checkIntersection(PointsAdj, EyeSmallBox);
%             figure;
%             faceImage = insertObjectAnnotation(I,'rectangle',EyeSmallBox,'EyeBig');
%             imshow(faceImage);
%             hold on
%             max_len = 0;
%             for k = 1:length(lines)
%                 xy = [lines(k).point1; lines(k).point2];
%                 plot(xy(:,1)+EyeSmallBox(1),xy(:,2)+EyeSmallBox(2),'LineWidth',2,'Color','green');
%                 
%                 % Plot beginnings and ends of lines
%                 plot(xy(1,1)+EyeSmallBox(1),xy(1,2)+EyeSmallBox(2),'x','LineWidth',2,'Color','yellow');
%                 plot(xy(2,1)+EyeSmallBox(1),xy(2,2)+EyeSmallBox(2),'x','LineWidth',2,'Color','red');
%                 
%                 % Determine the endpoints of the longest line segment
%                 len = norm(lines(k).point1 - lines(k).point2);
%                 if ( len > max_len)
%                     max_len = len;
%                     xy_long = xy;
%                 end
%             end
%             plot(xy_long(:,1)+EyeSmallBox(1),xy_long(:,2)+EyeSmallBox(2),'LineWidth',2,'Color','cyan');
%             title("Hough and ROI's");
%             hold off
%        end
        % Check if Face is found
    elseif found(4)
        MaskDect(i-2) = checkIntersection(Points, EyeBox);
    elseif found(3)
        MaskDect(i-2) = 0;
    end
    %pause;
    % Switch back to folder to get next image in following loop
    cd ..; cd NewCropped;
end
figure;
histogram(MedColor); title('Norm of Median Color Distances');
figure;
histogram(AvColor); title('Norm of Mean Color Distances');
DectBinary = (MaskDect==MaskReal);
Acc = mean(DectBinary);
% Move back to code folder
cd ..; cd Code;
end
