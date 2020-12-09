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
NoDetect = 0;
% Loop through each image
<<<<<<< HEAD
<<<<<<< Updated upstream
for i = 3:numI
    currI = Ifiles(i).name;
=======
<<<<<<< HEAD
<<<<<<< HEAD
for i = 1:numI-3
    currI = Ifiles(i+2).name;
=======
for i = 3:numI
    currI = Ifiles(i).name;
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
=======
for i = 3:numI
    currI = Ifiles(i).name;
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
>>>>>>> Stashed changes
=======
for i = 3:numI
    currI = Ifiles(i).name;
>>>>>>> parent of 330226b... Color Intensity Classification Method Implemented
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
    
<<<<<<< Updated upstream
     figure;
%     faceImage = insertObjectAnnotation(I,'rectangle',[FaceBox;EyeSmallBox;EyeBigBox;EyeBox; MouthBox; NoseBox],'ROI');
    imshow(I);
        hold on
        max_len = 0;
        for k = 1:length(lines)
            xy = [lines(k).point1; lines(k).point2];
            plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
=======
<<<<<<< HEAD
<<<<<<< HEAD
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
<<<<<<< HEAD
        MaskDect(i) = checkIntersection(Points, EyeBigBox);
        if not(MaskDect(i))
            if CurrMedDist >= MedThresh || CurrAvDist >= AvThresh
                MaskDect(i) = 1;
=======
     figure;
%     faceImage = insertObjectAnnotation(I,'rectangle',[FaceBox;EyeSmallBox;EyeBigBox;EyeBox; MouthBox; NoseBox],'ROI');
    imshow(I);
        hold on
        max_len = 0;
        for k = 1:length(lines)
            xy = [lines(k).point1; lines(k).point2];
            plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
=======
     figure;
%     faceImage = insertObjectAnnotation(I,'rectangle',[FaceBox;EyeSmallBox;EyeBigBox;EyeBox; MouthBox; NoseBox],'ROI');
    imshow(I);
        hold on
        max_len = 0;
        for k = 1:length(lines)
            xy = [lines(k).point1; lines(k).point2];
            plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
>>>>>>> Stashed changes
            % Plot beginnings and ends of lines
            plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
            plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
            % Determine the endpoints of the longest line segment
            len = norm(lines(k).point1 - lines(k).point2);
            if ( len > max_len)
                max_len = len;
                xy_long = xy;
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
=======
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
>>>>>>> Stashed changes
            end
        else
%             EyeBigBoxEXT(1:3) = EyeBigBox(1:3);
%             EyeBigBoxEXT(4) = EyeBigBox(4)*2;
%             figure;
%             faceImage = insertObjectAnnotation(I,'rectangle',EyeBigBoxEXT,'Eye ROI Extended');
%             imshow(faceImage);
%             hold on
%             max_len = 0;
%             for k = 1:size(Points,1)
%                 xy = [Points{k,1}; Points{k,2}];
%                 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%                 
%                 % Plot beginnings and ends of lines
%                 plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','m');
%                 plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
%                 
%                 % Determine the endpoints of the longest line segment
%                 len = norm(lines(k).point1 - lines(k).point2);
%                 if ( len > max_len)
%                     max_len = len;
%                     xy_long = xy;
%                 end
%             end
%             plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
%             title("Small Angle Hough Lines and ROI");
%             hold off
%             pause
        end
        plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
        title("Hough and ROI's");
        hold off
    
    % Check if BigEyePair is found
    if found(2)
=======
>>>>>>> parent of 330226b... Color Intensity Classification Method Implemented
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
<<<<<<< HEAD
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
        MaskDect(i) = checkIntersection(Points, EyeSmallBox);
        if not(MaskDect(i))
            if CurrMedDist >= MedThresh || CurrAvDist >= AvThresh 
                MaskDect(i) = 1;
            end
        else
%             figure;
%             EyeBigBoxEXT(1:3) = EyeBigBox(1:3);
%             EyeBigBoxEXT(4) = EyeBigBox(4)*2;
%             faceImage = insertObjectAnnotation(I,'rectangle',EyeBigBox,'Eye ROI Extended');
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
=======
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
>>>>>>> Stashed changes
=======
>>>>>>> parent of 330226b... Color Intensity Classification Method Implemented
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
<<<<<<< HEAD
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
%                 xy = [Points{k,1}; Points{k,2}];
%                 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%                 
%                 % Plot beginnings and ends of lines
%                 plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%                 plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
=======
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
>>>>>>> Stashed changes
=======
>>>>>>> parent of 330226b... Color Intensity Classification Method Implemented
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
<<<<<<< HEAD
<<<<<<< Updated upstream
=======
>>>>>>> parent of 330226b... Color Intensity Classification Method Implemented
%             plot(xy_long(:,1)+EyeSmallBox(1),xy_long(:,2)+EyeSmallBox(2),'LineWidth',2,'Color','cyan');
%             title("Hough and ROI's");
%             hold off
%        end
        % Check if Face is found
<<<<<<< HEAD
    elseif found(4)
        MaskDect(i-2) = checkIntersection(Points, EyeBox);
    elseif found(3)
        MaskDect(i-2) = 0;
    end
    %pause;
    % Switch back to folder to get next image in following loop
    cd ..; cd NewCropped;
end
=======
<<<<<<< HEAD
%             plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
%             title("Hough and ROI's");
%             hold off
%             pause
        end
        % Check if Created Eyebox is found
    elseif found(4)
        MaskDect(i) = checkIntersection(Points, EyeBox);
        % Check if FaceBox is found
    elseif found(3)
        MaskDect(i) = 0;
        if not(MaskDect(i))
            if CurrMedDist >= MedThresh || CurrAvDist >= AvThresh
                MaskDect(i) = 1;
            end
        end
    else
        MaskDect(i) = 1;
        NoDetect = NoDetect+1;
    end
    
    % pause
    % Switch back to folder to get next image in following loop
    cd ..; cd NewCropped;
end
% Histograms for Med and Av colors
% Edges = 0:10:250;
% figure;
% histogram(MedColorM,Edges);
% hold on
% histogram(MedColorN,Edges);
% title('Magnitude of Median Color Distance');
% legend('Mask', 'No Mask');
% xlabel('RGB Distance Magnitude');
% ylabel('Frequency');
% hold off
% figure;
% histogram(AvColorM,Edges);
% hold on
% histogram(AvColorN,Edges);
% title('Magnitude of Mean Color Distance');
% legend('Mask', 'No Mask');
% xlabel('RGB Distance Magnitude');
% ylabel('Frequency');
% hold off
% Detecting if the algorithm is working/Accuracy
=======
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
=======
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
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
>>>>>>> Stashed changes
=======
    elseif found(4)
        MaskDect(i-2) = checkIntersection(Points, EyeBox);
    elseif found(3)
        MaskDect(i-2) = 0;
    end
    %pause;
    % Switch back to folder to get next image in following loop
    cd ..; cd NewCropped;
end
>>>>>>> parent of 330226b... Color Intensity Classification Method Implemented
figure;
histogram(MedColor); title('Norm of Median Color Distances');
figure;
histogram(AvColor); title('Norm of Mean Color Distances');
<<<<<<< HEAD
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
=======
>>>>>>> ad15b02486c025c1ea523548bd9ba48fb087350a
>>>>>>> Stashed changes
=======
>>>>>>> parent of 330226b... Color Intensity Classification Method Implemented
DectBinary = (MaskDect==MaskReal);
Acc = mean(DectBinary);
% Move back to code folder
cd ..; cd Code;
end
