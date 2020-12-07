%% Acuracy test
% 

function [Acc, MaskDect, DectBinary] = test_accuracy()
% Get Mask Data for Images
MaskReal = xlsread('CroppedSetMaskorNot.xlsx');
MaskDect = zeros(size(MaskReal));
% Move to folder containing images
cd ..; cd NewCropped;
Ifiles = dir();
numI = size(Ifiles,1);

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
    [EyeSmallBox, EyeBigBox, FaceBox, found] = feature_detection(I);
    % Check if Face is found
    if found(3)
        MaskDect(i-2) = 0;
    % Check if BigEyePair is found
    elseif found(2)
        MaskDect(i-2) = checkIntersection(Points, EyeBigBox);
    % Check if SmallEyePair is found
    elseif found(1)
        MaskDect(i-2) = checkIntersection(Points, EyeSmallBox);
    end
    % Switch back to folder to get next image in following loop
    cd ..; cd NewCropped;
end
DectBinary = (MaskDect==MaskReal);
Acc = mean(DectBinary);
% Move back to code folder
cd ..; cd Code;
end
