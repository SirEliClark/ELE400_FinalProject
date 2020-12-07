%% Eli Clark
% ELE 400 Fall '20
% markcorners
%   recieves original image, list of corner locations
%   displays image

function out = markcorners(Im, Ic, w)
[m, n] = size(Im);
I = zeros(m,n,3);
I(:,:,1) = Im; I(:,:,2) = Im; I(:,:,3) = Im;
l = find(Ic(:,1),1,'last');
for i = 1:l
    I(Ic(i,1)-w:Ic(i,1)+w,Ic(i,2)-w:Ic(i,2)+w,1) = 255;
    I(Ic(i,1)-w:Ic(i,1)+w,Ic(i,2)-w:Ic(i,2)+w,2) = 0;
    I(Ic(i,1)-w:Ic(i,1)+w,Ic(i,2)-w:Ic(i,2)+w,3) = 0;
end
figure; imshow(uint8(I));
out = I;
end