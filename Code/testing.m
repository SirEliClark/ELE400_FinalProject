clear all;
close all;
I_color = imrotate(imread('Jack_MaskWrong.jpeg'),-90);
I_color = imresize(I_color,[500,500]);
I_mask = imrotate(imread('Jack_MaskWrong.jpeg'),-90);
I_mask = rgb2gray(I_mask);
I_mask = imresize(I_mask,[500,500]);
figure; imshow(I_mask); title('Original BW Image');
[rows,cols] = size(I_mask);


detector = vision.CascadeObjectDetector;
bbox = detector(I_color);
ptR = bbox(2);
ptC = bbox(1);
w = bbox(3);
h = bbox(4);
faceImage = insertObjectAnnotation(I_color,'rectangle',bbox,'Face');
figure; imshow(faceImage)

I_cropped = I_color(ptR:ptR+h,ptC:ptC+w,:);
figure; imshow(I_cropped);

detectRightEye = vision.CascadeObjectDetector('RightEye');
