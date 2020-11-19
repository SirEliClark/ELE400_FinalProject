function [Es, Eo] = CannyEnhancer(sigma,inputImage)

J = GaussianFilt(sigma,inputImage);
k_x = [-1 0 1];
k_y = [-1;0;1];
Jx = conv2(J,k_x,'same');
Jy = conv2(J,k_y,'same');

Es = sqrt(Jx.^2 + Jy.^2);
Eo = atan2d(Jy,Jx); % Used atan2d because atand produced NaN for some values 
end

