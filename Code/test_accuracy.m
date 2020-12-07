%% Acuracy test
% 

function [Ifiles, numI] = test_accuracy()
% Get Mask Data for Images
MaskBool = xlsread('C:\Users\Eli Clark\Documents\Fall_20\ELE_400\FinalProjectELE400_FinalProject\CroppedSetMaskorNot');
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
    % Get eye/face bounding boxes
    [EyeSmallBox, EyeBigBox, FaceBox, found] = feature_detection(I)
    % Check if Face is found
    if found(3)
        
    % Check if BigEyePair is found
    elseif found(2)
        
    % Check if SmallEyePair is found
    elseif found(1)
        
    end
    % Switch back to folder to get next image in following loop
    cd ..; cd NewCropped;
end

% Move back to code folder
cd ..; cd Code;
end
