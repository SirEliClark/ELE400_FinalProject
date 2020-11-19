function [filteredImage] = GaussianFilt(sigma,I1)

len = 5*sigma;
if mod(len,2)==0
    len = len +1;
elseif mod(len,2) > 1
    len = ceil(len+1);
elseif mod(len,2) < 1
    len = ceil(len);   
end
x = -(len-1)/2:(len-1)/2;
g = 1/sqrt(2*pi*sigma^2) * exp(-x.^2/(2*sigma^2));
g = round(g/g(1));
g = g/sum(g);

filteredImage = uint8(conv2(g,g,I1,'same'));

end

