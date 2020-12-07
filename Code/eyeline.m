%% Find Eye Line
% Recieves Original Image
% Finds Eyes, the corners of the eyes, and the line through those corners

function Iline = feature_detection(I)

% EyeSmall detection
detector = vision.CascadeObjectDetector('EyePairSmall');
bbox = detector(I);
if bbox
    ptR = bbox(2);
    ptC = bbox(1);
    w = bbox(3);
    h = bbox(4);
    faceImage = insertObjectAnnotation(I,'rectangle',bbox,'Small Eyes');
    figure; imshow(faceImage); title('Eyes Detected');
end

% EyeSmall detection
detector = vision.CascadeObjectDetector('EyePairBig');
eyeBigbox = detector(I);
if eyeBigbox
    faceImage = insertObjectAnnotation(I,'rectangle',eyeBigbox,'Big Eyes');
    figure; imshow(faceImage); title('Eyes Detected');
end

% EyeSmall detection
detector = vision.CascadeObjectDetector('EyePairBig');
bbox = detector(I);
if bbox
    ptR = bbox(2);
    ptC = bbox(1);
    w = bbox(3);
    h = bbox(4);
    faceImage = insertObjectAnnotation(I,'rectangle',bbox,'Big Eyes');
    figure; imshow(faceImage); title('Eyes Detected');
end

% Face detection
detector = vision.CascadeObjectDetector('RightEye');
bbox = detector(I);
if bbox
    ptR = bbox(2);
    ptC = bbox(1);
    w = bbox(3);
    h = bbox(4);
    faceImage = insertObjectAnnotation(I,'rectangle',bbox,'Right Eye');
    figure; imshow(faceImage); title('Right Eye Detected');
end

% Nose detection
detector = vision.CascadeObjectDetector('Nose');
bbox = detector(I);
if bbox
    ptR = bbox(2);
    ptC = bbox(1);
    w = bbox(3);
    h = bbox(4);
    faceImage = insertObjectAnnotation(I,'rectangle',bbox,'Nose');
    figure; imshow(faceImage); title('Nose Detected');
end

% % Detect upper body
% detector = vision.CascadeObjectDetector('UpperBody');
% bbox = detector(I);
% if bbox
%     ptR = bbox(2);
%     ptC = bbox(1);
%     w = bbox(3);
%     h = bbox(4);
%     faceImage = insertObjectAnnotation(I,'rectangle',bbox,'Upper Body');
%     figure; imshow(faceImage); title('Upper Body Detected');
% end

end