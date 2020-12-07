%% Find Eye Line
% Recieves Original Image
% Uses Cascade Object Detector
% Attempts to find 'EyePairBig','EyePairSmall','Face'
% Returns bounding boxes, and boolean array whether found or not

function [EyeSmallBox, EyeBigBox, FaceBox, found] = feature_detection(I)
% Boolean array for if boxes are found
found = ones(3,1);
% EyeSmall detection
detector = vision.CascadeObjectDetector('EyePairSmall');
EyeSmallBox = detector(I);
if (EyeSmallBox)
    found(1) = 0;
    % faceImage = insertObjectAnnotation(I,'rectangle',EyeSmallBox,'Small Eyes');
    % figure; imshow(faceImage); title('Eyes Detected');
end

% Eye Pair Big detection
detector = vision.CascadeObjectDetector('EyePairBig');
EyeBigBox = detector(I);
if EyeBigBox
    found(2) = 0;
    % faceImage = insertObjectAnnotation(I,'rectangle',EyeBigBox,'Big Eyes');
    % figure; imshow(faceImage); title('Eyes Detected');
end

% Face detection
detector = vision.CascadeObjectDetector('RightEye');
FaceBox = detector(I);
if FaceBox
    found(3) = 0;
    faceImage = insertObjectAnnotation(I,'rectangle',FaceBox,'Right Eye');
    figure; imshow(faceImage); title('Right Eye Detected');
end

% Nose detection
% detector = vision.CascadeObjectDetector('Nose');
% NoseBox = detector(I);
% if NoseBox
%     faceImage = insertObjectAnnotation(I,'rectangle',NoseBox,'Nose');
%     figure; imshow(faceImage); title('Nose Detected');
% end

% % Detect upper body
% detector = vision.CascadeObjectDetector('UpperBody');
% UpBodBox = detector(I);
% if UpBodBox
%     faceImage = insertObjectAnnotation(I,'rectangle',UpBodBox,'Upper Body');
%     figure; imshow(faceImage); title('Upper Body Detected');
% end

end