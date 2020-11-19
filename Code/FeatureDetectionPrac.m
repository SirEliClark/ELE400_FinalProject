


function [bbox,i] = FeatureDetectionPrac()
cd ..; cd FaceMaskDataset;
% Check Train, Test, or Validation images, choose WithMask or Without Mask
% Finish moving to the right directory
cd Train; % cd Validation; % cd Test;
cd WithoutMask; % cd WithMask;
% Collect information of all .png images (all iamges are .png) in directory
ImageFiles = dir('*.png');
for i = 1:length(ImageFiles) % Loop through all images
    % Get the current image information
    currIm = ImageFiles(i);
    Im = imread(currIm.name); % Read in the current image
    [h, w, ~] = size(Im); % Check how large the image is
    if h >= 150 && w >= 150
        detector = vision.CascadeObjectDetector('EyePairSmall');
        bbox = detector(Im);
        ptR = bbox(2);
        ptC = bbox(1);
        w = bbox(3);
        h = bbox(4);
        faceImage = insertObjectAnnotation(Im,'rectangle',bbox,'Right Eye');
        figure; imshow(faceImage)
        pause;
        I_cropped = Im(ptR:ptR+h,ptC:ptC+w,:);
        figure; imshow(I_cropped);
        break
    end
end
% Return the directory where this script is located
cd ..; cd ..; cd ..; cd Code;
% I_color = imrotate(imread('Jack_MaskWrong.jpeg'),-90);
% I_color = imresize(I_color,[500,500]);
% I_mask = imrotate(imread('Jack_MaskWrong.jpeg'),-90);
% I_mask = rgb2gray(I_mask);
% I_mask = imresize(I_mask,[500,500]);
% figure; imshow(I_mask); title('Original BW Image');
% [rows,cols] = size(I_mask);




%detectRightEye = vision.CascadeObjectDetector('RightEye');



end