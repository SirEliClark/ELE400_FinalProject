%% Morphological opperations
% Apply morphological opperation closing of the opening
% Recieves original image, size, and shape of structuring element

function [closed] = morph_opcl(Im, size, shape)
    opened = imopen(Im, strel(shape,size));
    closed = imclose(opened, strel(shape,size));
    figure; imshow(uint8(closed)); title('Post Morphological Opperations');
end