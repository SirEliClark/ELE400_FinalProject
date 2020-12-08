%% Edge detection


function lines = edge_detection_Final(I)
% Parameters for Edge Detection
sigma = 0.8;
threshold_low = 5;
threshold_high = 40;
Ig = rgb2gray(I);
[rows,cols] = size(Ig);

% Edge Detection
[E_strenght, E_orientation] = CannyEnhancer(sigma,Ig);
[I_nonMax, Eo_new] = NonMaxSupression(E_strenght, E_orientation);
%figure; imshow(uint8(I_nonMax)); title('Non-Max Ouput');
[points, chainLen] = Hysterisis(I_nonMax,threshold_low,threshold_high,Eo_new);

% Get histogram for values of >1 from I_nonMax
fracNonMax = .1;
I_col = I_nonMax(:);
I_sortLH = sort(I_col);
%I_sortHL = sort(I_col,'descend');
NumG1 = find((I_sortLH>0),1);
NumUsed = round((length(I_sortLH)-NumG1)*fracNonMax);
threshNew = I_sortLH(end-NumUsed);

% start = find((I_sortLH>1),1);

% figure;
% histogram(I_sortLH(start:end));
I_nonMax(:,1:5) = 0;
I_nonMax(1:5,:) = 0;
I_nonMax(:,cols-5:cols) = 0;
I_nonMax(rows-5:rows,:) = 0;

%Making strong edges stronger
for r = 4:rows-4
    for c = 4:cols-4
        if(I_nonMax(r,c) >= threshNew)
            I_nonMax(r,c) = 255;
        else
            I_nonMax(r,c) = 0;
        end
    end
end
%figure; imshow(uint8(I_nonMax));title('New Non-Max');

binaryIm = imbinarize(I_nonMax);
%figure;
% Hough Lines
[H,theta,rho] = hough(binaryIm);
P = houghpeaks(H,5,'threshold',ceil(0.5*max(H(:)))); %Find peaks
%imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit'); title('Peaks')
%xlabel('\theta'), ylabel('\rho');
%axis on, axis normal, hold on;
%Plot Peaks
x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','white');
lines = houghlines(binaryIm,theta,rho,P,'FillGap',5,'MinLength',7);


end
