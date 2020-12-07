%% Reads in image sizes from train set

function [sizes] = checkImSizes()
% Back out of Code directory, move into NewDataset where iamges are
cd ..; cd NewDataset;
% Collect information of all .jpg images (all iamges are .png) in directory
JPGFiles = dir('*.jpg');
JPEGFiles = dir('*.jpeg');
PNGFiles = dir('*.png');
% Initialize number of large images and empty cell array (hold image names)
sizes = zeros(1,4); %name = {};
for i = 1:length(JPGFiles) % Loop through all images 
    % Get the current image information
    currIm = JPGFiles(i);
    Im = imread(currIm.name); % Read in the current image
    [~, w, ~] = size(Im); % Check how large the image is
    if w < 500 % If it is larger than this threshold
        sizes(1) = sizes(1)+1;
    elseif w < 750
        sizes(2) = sizes(2)+1;
    elseif w < 1000
        sizes(3) = sizes(3)+1;
    else 
        sizes(4) = sizes(4)+1;
    end
end
for i = 1:length(JPEGFiles) % Loop through all images 
    % Get the current image information
    currIm = JPEGFiles(i);
    Im = imread(currIm.name); % Read in the current image
    [~, w, ~] = size(Im); % Check how large the image is
    if w < 500 % If it is larger than this threshold
        sizes(1) = sizes(1)+1;
    elseif w < 750
        sizes(2) = sizes(2)+1;
    elseif w < 1000
        sizes(3) = sizes(3)+1;
    else 
        sizes(4) = sizes(4)+1;
    end
end
for i = 1:length(PNGFiles) % Loop through all images 
    % Get the current image information
    currIm = PNGFiles(i);
    Im = imread(currIm.name); % Read in the current image
    [~, w, ~] = size(Im); % Check how large the image is
    if w < 500 % If it is larger than this threshold
        sizes(1) = sizes(1)+1;
    elseif w < 750
        sizes(2) = sizes(2)+1;
    elseif w < 1000
        sizes(3) = sizes(3)+1;
    else 
        sizes(4) = sizes(4)+1;
    end
end
% Return the directory where this script is located
cd ..; cd Code;
end