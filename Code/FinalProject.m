%% ELE 400 Final Project
% Eli Clark and Jack Guida
% Fall '20
clc; close all; clear;
%% Read in images
I_color = imrotate(imread('Jack_Mask.jpeg'),-90);
I_color = imresize(I_color,[1000,1000]);
I_mask = imrotate(imread('Jack_Mask.jpeg'),-90);
I_mask = rgb2gray(I_mask);
I_mask = imresize(I_mask,[1000,1000]);
%figure; imshow(I_mask); title('Original BW Image');
[rows,cols] = size(I_mask);

%% Parameters for Edge Detection
sigma = 0.8;
threshold_low = 5;
threshold_high = 40;


%% Edge Detection
[E_strenght, E_orientation] = CannyEnhancer(sigma,I_mask);
[I_nonMax, Eo_new] = NonMaxSupression(E_strenght, E_orientation);
figure; imshow(uint8(I_nonMax)); title('Non-Max Ouput');
[points, chainLen] = Hysterisis(I_nonMax,threshold_low,threshold_high,Eo_new);

I_nonMax(:,1:5) = 0;
I_nonMax(1:5,:) = 0;
I_nonMax(:,cols-5:cols) = 0;
I_nonMax(rows-5:rows,:) = 0;
%Making strong edges stronger
for r = 4:rows-4
    for c = 4:cols-4
        if(I_nonMax(r,c) > 25)
            I_nonMax(r,c) = 255;
        else
            I_nonMax(r,c) = 0;
        end
    end
end
figure; imshow(uint8(I_nonMax));title('New Non-Max');

binaryIm = imbinarize(I_nonMax);

%% Hough Transform
[H,theta,rho] = hough(binaryIm);
P = houghpeaks(H,5,'threshold',ceil(0.5*max(H(:)))); %Find peaks
imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit'); title('Peaks')
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
%Plot Peaks
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','white');
lines = houghlines(binaryIm,theta,rho,P,'FillGap',5,'MinLength',7);

figure, imshow(I_mask), hold on
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
    % Plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
    % Determine the endpoints of the longest line segment
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');

%% connecting chains
runningSum = 0;
newChainLen = [];
skipNext = zeros(length(chainLen),1);
for i = 1:length(chainLen)
    runningSum = runningSum + chainLen(i);
    if(skipNext(i) == 0)
        lastPt = points(runningSum,:);
        if(i == length(chainLen))
            nextPt = points(1,:);
        else
            nextPt = points(runningSum+1,:);
        end
        if(abs(nextPt(1) - lastPt(1)) < 3 && abs(nextPt(2) - lastPt(2)) < 3)
            newChainLen = [newChainLen;(chainLen(i) + chainLen(i+1))];
            skipNext(i+1) = 1;
        else
            newChainLen = [newChainLen; chainLen(i)];
        end
    end
end

%% Find and display 10 Longest Chains
[longestChains, index] = maxk(chainLen,10);
%[longestChains, index] = maxk(newChainLen,10);

rgbChains = zeros(rows,cols,3);
rgbCombos = [151 234 244; 87 82 126; 150 177 208; 239 180 193; 231 227 181;
    0 104 132; 246 143 160; 255 173 47; 140 101 211; 177 221 161];

for i = 1:10
    currIndex = sum(chainLen(1:index(i)));
    %currIndex = sum(newChainLen(1:index(i)));
    rgbCurr = rgbCombos(i,:);
    
    for j = currIndex-longestChains(i)+1:currIndex
        
        currPoint = points(j,:);
        r = currPoint(1);
        c = currPoint(2);
        red = rgbCurr(1);
        blue = rgbCurr(3);
        green = rgbCurr(2);
        rgbChains(r,c,1) = red;
        rgbChains(r,c,2) = green;
        rgbChains(r,c,3) = blue;
        
    end
    
end

figure;
imshow(uint8(rgbChains));title('10 Longest Chains for Current Image')


%% HSV Function - Eye Detection

HSV = rgb2hsv(I_color);
sat = HSV(:,:,2);
sat = imbinarize(sat);
figure;imshow(sat);

%% Apply Morphological operations
% Convert binary image to 8 bit values
Im = sat*255;
% Apply morphological opperation closing of the oppening
Imorph = morph_opcl(Im, 6, 'diamond');
% % Erode the image
% erodedIm = imerode(Im,strel('disk',8));
% figure; imshow(uint8(erodedIm));
% % Dialte the eroded image
% dilatedIm = imdilate(erodedIm,strel('disk',8));
% figure; imshow(uint8(dilatedIm));

%% Apply corner detection
% Set values for sigma, threshold and nieghborhood for corner detection
s = 1.2; t = 400000; N = 5;
Is = GaussianFilt(1, Imorph);
Corners = detect_corners(Is, t, N);
Imarked = markcorners(Imorph, Corners, 3);
title('Corners Detected');

%% Get Eye regions on original image
detector = vision.CascadeObjectDetector('EyePairSmall');
bbox = detector(I_color);
ptR = bbox(2);
ptC = bbox(1);
w = bbox(3);
h = bbox(4); 
faceImage = insertObjectAnnotation(I_color,'rectangle',bbox,'Eyes');
figure; imshow(faceImage); title('Eyes Detected');
% Crop image to face region, only for face detection
% I_cropped = I_color(ptR:ptR+h,ptC:ptC+w,:);
% figure; imshow(I_cropped);

%% Isolate corners inside bbox
% loop through detected corners
l = find(Corners(:,1),1,'last');
EyeC = [];
for i = 1:l
    % If corner lies in bounding box
    if Corners(i,1) >= ptR && Corners(i,1) <= ptR+h
        if Corners(i,2) >= ptC+d && Corners(i,2) <= ptC+w-d
            EyeC = [EyeC; Corners(i,1) Corners(i,2)];
        end
    end
end
% Mark eye corners
IeyeC = I_color;
[m, ~] = size(EyeC); w = 3;
for i = 1:m
    IeyeC(EyeC(i,1)-w:EyeC(i,1)+w,EyeC(i,2)-w:EyeC(i,2)+w,1) = 255;
    IeyeC(EyeC(i,1)-w:EyeC(i,1)+w,EyeC(i,2)-w:EyeC(i,2)+w,2) = 0;
    IeyeC(EyeC(i,1)-w:EyeC(i,1)+w,EyeC(i,2)-w:EyeC(i,2)+w,3) = 0; 
end
figure; imshow(uint8(IeyeC)); title('Corners in Eye Box');

%% Draw line through eye level 
EyeCSorted = sortrows(EyeC,2);
ColEls = EyeCSorted(1,2):3:EyeCSorted(end,2);
RowEls = round(linspace(EyeCSorted(1,1),EyeCSorted(end,1),length(ColEls)));
IeyeLine = I_color;
[m, ~] = size(EyeC); w = 3;
for i = 1:length(RowEls)
    IeyeLine(RowEls(i),ColEls(i),1) = 0;
    IeyeLine(RowEls(i),ColEls(i),2) = 0;
    IeyeLine(RowEls(i),ColEls(i),3) = 255;
end
for i = 1:m
    IeyeLine(EyeC(i,1)-w:EyeC(i,1)+w,EyeC(i,2)-w:EyeC(i,2)+w,1) = 255;
    IeyeLine(EyeC(i,1)-w:EyeC(i,1)+w,EyeC(i,2)-w:EyeC(i,2)+w,2) = 0;
    IeyeLine(EyeC(i,1)-w:EyeC(i,1)+w,EyeC(i,2)-w:EyeC(i,2)+w,3) = 0; 
end
figure; imshow(uint8(IeyeLine)); title('Line Through Eye Corners');


