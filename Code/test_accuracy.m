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
for i = 1:numI-2
    currI = Ifiles(i+2).name;
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
        CurrMedDist = norm(Med(1,:)-Med(2,:));
        CurrAvDist = norm(Av(1,:)-Av(2,:));
        if MaskReal(i)
            MedColorM(ColorCount) = CurrMedDist;
            AvColorM(ColorCount) = CurrAvDist;
        else
            MedColorN(ColorCount) = CurrMedDist;
            AvColorN(ColorCount) = CurrAvDist;
        end
        ColorCount = ColorCount+1;
    end
    % Median and average color thresholds
    MedThresh = 85;
    AvThresh = 75;
    % Hough lines and bounding boxes
    
%     figure;
%     faceImage = insertObjectAnnotation(I,'rectangle',[FaceBox;EyeSmallBox;EyeBigBox;EyeBox; MouthBox; NoseBox],'ROI');
%     imshow(faceImage);
%         hold on
%         max_len = 0;
%         for k = 1:length(lines)
%             xy = [lines(k).point1; lines(k).point2];
%             plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%     
%             % Plot beginnings and ends of lines
%             plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%             plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
%     
%             % Determine the endpoints of the longest line segment
%             len = norm(lines(k).point1 - lines(k).point2);
%             if ( len > max_len)
%                 max_len = len;
%                 xy_long = xy;
%             end
%         end
%         plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
%         title("Hough and ROI's");
%         hold off
    
    % Check if BigEyePair is found
    if found(2)
        MaskDect(i) = checkIntersection(Points, EyeBigBox);
        if not(MaskDect(i))
            if CurrAvDist >= AvThresh || CurrMedDist >= MedThresh
                MaskDect(i) = 1;
            end
        end
    % Check if SmallEyePair is found
    elseif found(1)
        MaskDect(i) = checkIntersection(Points, EyeSmallBox);
        if not(MaskDect(i))
            if CurrAvDist >= AvThresh || CurrMedDist >= MedThresh
                MaskDect(i) = 1;
            end
        end
    % Check if Created Eyebox is found
    elseif found(4)
        MaskDect(i) = checkIntersection(Points, EyeBox);
    % Check if FaceBox is found
    elseif found(3)
        MaskDect(i) = 0;
        if not(MaskDect(i))
            if CurrAvDist >= AvThresh || CurrMedDist >= MedThresh
                MaskDect(i) = 1;
            end
        end
    else
         MaskDect(i) = 1;
    end
    
    %pause;
    % Switch back to folder to get next image in following loop
    cd ..; cd NewCropped;
end
% Histograms for Med and Av colors
Edges = 0:5:250;
figure;
histogram(MedColorM,Edges);
hold on
histogram(MedColorN,Edges); 
title('Norm of Median Color Distances');
legend('Mask', 'No Mask');
hold off
figure;
histogram(AvColorM,Edges);
hold on
histogram(AvColorN,Edges);
title('Norm of Mean Color Distances');
legend('Mask', 'No Mask');
hold off
% Detecting if the algorithm is working/Accuracy
DectBinary = (MaskDect==MaskReal);
Acc = mean(DectBinary);
% Move back to code folder
cd ..; cd Code;
end
