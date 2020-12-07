%% Hue and saturation images

function HueSat(I)
% Get saturation image
HSV = rgb2hsv(I);
sat = imbinarize(HSV(:,:,2));
figure;imshow(sat); title('Saturation Binarized');
hue = imbinarize(HSV(:,:,1));
figure;imshow(hue); title('Hue Binarized');

% Im = (hue)*255;
% % Apply morphological opperation closing of the oppening
% Imorph = morph_opcl(Im, 5, 'disk');


end
