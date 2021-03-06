%% Reads in image sizes from train set

function [numLarge, name] = checkImSizes()
% Back out of Code directory, move into FaceMaskDataset, where iamges are
cd ..; cd FaceMaskDataset;
% Check Train, Test, or Validation images, choose WithMask or Without Mask 
% Finish moving to the right directory
cd Validation; % cd Test; % cd Train; 
cd WithMask; % cd WithoutMask; 
% Collect information of all .png images (all iamges are .png) in directory
ImageFiles = dir('*.png');
% Initialize number of large images and empty cell array (hold image names)
numLarge = 0; name = {};
for i = 1:length(ImageFiles) % Loop through all images 
    % Get the current image information
    currIm = ImageFiles(i);
    Im = imread(currIm.name); % Read in the current image
    [h, w, ~] = size(Im); % Check how large the image is
    if h >= 200 && w >= 200 % If it is larger than this threshold
        numLarge = numLarge + 1; % Increment number of large images
        name{numLarge,1} = currIm.name; % Save the name of the image
        % move to new folder to save just the large images in
%         cd ..; cd WithMaskLarge; 
%         imwrite(Im, currIm.name); % Write the image to current directory
%         cd ..; cd WithMask; % return to directory with all images
    end
end
% Return the directory where this script is located
cd ..; cd ..; cd ..; cd Code;
end