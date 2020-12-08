%% Find Eye Line
% Recieves Original Image
% Uses Cascade Object Detector
% Attempts to find 'EyePairBig','EyePairSmall','Face'
% Returns bounding boxes, and boolean array whether found or not

function [EyeSmallBox, EyeBigBox, FaceBox, NewEyeBox, found, Med, Av] = feature_detection(I)
% Boolean array for if boxes are found
found = zeros(6,1);
% EyeSmall detection
detector = vision.CascadeObjectDetector('EyePairSmall');
EyeSmallBox = detector(I);
if (EyeSmallBox)
    found(1) = 1;
    if size(EyeSmallBox,1) > 1
        [h,w,~] = size(I);
        for i = 1:size(EyeSmallBox,1)
            CenterC = EyeSmallBox(i,1)+EyeSmallBox(i,3)/2;
            CenterR = EyeSmallBox(i,1)+EyeSmallBox(i,3)/2;
            IcenterC = w/2;
            IcenterR = h/2;
            Dist(i) = sqrt((CenterC-IcenterC)^2+(CenterR-IcenterR)^2);
        end
        [~,Index] = min(Dist);
        TempBox = EyeSmallBox(Index,:);
        EyeSmallBox = zeros(1,4);
        EyeSmallBox = TempBox;
    end
    %faceImage = insertObjectAnnotation(I,'rectangle',EyeSmallBox,'Small Eyes');
    %figure; imshow(faceImage); title('Eyes Detected');
end

% Eye Pair Big detection
detector = vision.CascadeObjectDetector('EyePairBig');
EyeBigBox = detector(I);
if EyeBigBox
    found(2) = 1;
    if size(EyeBigBox,1) > 1
        [h,w,~] = size(I);
        for i = 1:size(EyeBigBox,1)
            CenterC = EyeBigBox(i,1)+EyeBigBox(i,3)/2;
            CenterR = EyeBigBox(i,1)+EyeBigBox(i,3)/2;
            IcenterC = w/2;
            IcenterR = h/2;
            Dist(i) = sqrt((CenterC-IcenterC)^2+(CenterR-IcenterR)^2);
        end
        [~,Index] = min(Dist);
        TempBox = EyeBigBox(Index,:);
        EyeBigBox = zeros(1,4);
        EyeBigBox = TempBox;
    end
    %faceImage = insertObjectAnnotation(I,'rectangle',EyeBigBox,'Big Eyes');
    %figure; imshow(faceImage); title('Eyes Detected');
end

% Face detection
detector = vision.CascadeObjectDetector();
FaceBox = detector(I);
if FaceBox
    found(3) = 1;
    % Get rid of face boxes that are really small
    [Ih, Iw, ~] = size(I);
    if size(FaceBox,1)
        Eyeh = FaceBox(4); Eyew = FaceBox(3);
        FracH = Eyeh/Ih; FracW = Eyew/Iw;
        if FracH < 0.3 && FracW < 0.3
            found(3) = 0;
            FaceBox = [1,1,0,0];
        end
    else
        for i = 1:size(FaceBox,1)
            Eyeh = FaceBox(i,4); Eyew = FaceBox(i,3);
            FracH = Eyeh/Ih; FracW = Eyew/Iw;
            if FracH < 0.3 && FracW < 0.3
                
                FaceBox(i,:) = [1,1,0,0];
            end
        end
        if FaceBox(:,4) == zeros(size(FaceBox,1),1)
            found(3) = 0;
        end
    end
    %faceImage = insertObjectAnnotation(I,'rectangle',FaceBox,'Face');
    %figure; imshow(faceImage); title('Face Detected');
    %pause
end

if found(1) == 0 && found(2) == 0
    % Right Eye detection
    detector = vision.CascadeObjectDetector('RightEye');
    EyeBox = detector(I);
    if size(EyeBox,1) >= 2
        found(4) = 1;
        % Remove Eyebox near edges
        CDist = zeros(size(EyeBox,1),2);
        Center = round([size(I,2)/2,size(I,1)/2]);
        for i = 1:size(EyeBox,1)
            CDist(i,1) = min([abs(EyeBox(i,1)-Center(1)),abs(EyeBox(i,1)+EyeBox(i,3)-Center(1))]);
            CDist(i,2) = min([abs(EyeBox(i,2)-Center(2)),abs(EyeBox(i,2)+EyeBox(i,4)-Center(2))]);
            Dist(i) = sqrt(CDist(i,1)^2+CDist(i,2)^2);
        end
        [~, Index] = mink(Dist,2);
        EyeBox = [EyeBox(Index(1),:); EyeBox(Index(2),:)];
        NewEyeBox = zeros(1,4);
        [~, Left] = min([EyeBox(1,1),EyeBox(2,1)]);
        [~, Right] = max([EyeBox(1,1),EyeBox(2,1)]);
        [~, Top] = min([EyeBox(1,2),EyeBox(2,2)]);
        [~, Bot] = max([EyeBox(1,2),EyeBox(2,2)]);
        NewEyeBox(1) = EyeBox(Left,1);
        NewEyeBox(2) = EyeBox(Left,2);
        NewEyeBox(3) = EyeBox(Right,1)-EyeBox(Left,1)+EyeBox(Right,3);
        NewEyeBox(4) = EyeBox(Bot,2)-EyeBox(Top,2)+EyeBox(Bot,4);
        NewEyeBox;
        % faceImage = insertObjectAnnotation(I,'rectangle',NewEyeBox,'Right Eyes');
        % figure; imshow(faceImage); title('Eyes Detected');
    else 
        NewEyeBox = EyeBox;
    end
end
if found(4) == 0
    NewEyeBox = [1, 1, 0, 0];
end

Med = zeros(2,3);
Av = zeros(2,3);
if found(2)
    % Upper Region
    Reg1 = I(EyeBigBox(2)-EyeBigBox(4):EyeBigBox(2)+EyeBigBox(4),EyeBigBox(1):EyeBigBox(1)+EyeBigBox(3),:);
    % Lower Region
    Reg2 = I(EyeBigBox(2)+EyeBigBox(4):EyeBigBox(2)+3*EyeBigBox(4),EyeBigBox(1):EyeBigBox(1)+EyeBigBox(3),:);
    Med(1,:) = median(Reg1,[1,2]); Med(2,:) = median(Reg2,[1,2]);
    Av(1,:) = mean(Reg1,[1,2]); Av(2,:) = mean(Reg2,[1,2]);
    % figure; imshow(I);
    % title(sprintf('(Top RGB,Bot RGB) - Median:(%0.2f,%0.2f,%0.2f - %0.2f,%0.2f,%0.2f) Average:(%0.2f,%0.2f,%0.2f - %0.2f,%0.2f,%0.2f)',Med(1,1),Med(1,2),Med(1,3),Med(2,1),Med(2,2),Med(2,3),Av(1,1),Av(1,2),Av(1,3),Av(2,1),Av(2,2),Av(2,3)));
elseif found(1)
    % Upper Region
    Reg1 = I(EyeSmallBox(2)-EyeSmallBox(4):EyeSmallBox(2)+EyeSmallBox(4),EyeSmallBox(1):EyeSmallBox(1)+EyeSmallBox(3),:);
    % Lower Region
    Reg2 = I(EyeSmallBox(2)+EyeSmallBox(4):EyeSmallBox(2)+3*EyeSmallBox(4),EyeSmallBox(1):EyeSmallBox(1)+EyeSmallBox(3),:);
    Med(1,:) = median(Reg1,[1,2]); Med(2,:) = median(Reg2,[1,2]);
    Av(1,:) = mean(Reg1,[1,2]); Av(2,:) = mean(Reg2,[1,2]);
    % figure; imshow(I);
    % title(sprintf('(Top RGB,Bot RGB) - Median:(%0.2f,%0.2f,%0.2f - %0.2f,%0.2f,%0.2f) Average:(%0.2f,%0.2f,%0.2f - %0.2f,%0.2f,%0.2f)',Med(1,1),Med(1,2),Med(1,3),Med(2,1),Med(2,2),Med(2,3),Av(1,1),Av(1,2),Av(1,3),Av(2,1),Av(2,2),Av(2,3)));
elseif found(4)
    % Upper Region
%     Reg1 = I(NewEyeBox(2)-NewEyeBox(4):NewEyeBox(2)+NewEyeBox(4),NewEyeBox(1):NewEyeBox(1)+NewEyeBox(3),:);
%     % Lower Region
%     Reg2 = I(NewEyeBox(2)+NewEyeBox(4):NewEyeBox(2)+3*NewEyeBox(4),NewEyeBox(1):NewEyeBox(1)+NewEyeBox(3),:);
%     Med(1) = median(Reg1); Med(2) = median(Reg2);
%     Av(1) = mean(Reg1); Av(2) = mean(Reg2);
end

end