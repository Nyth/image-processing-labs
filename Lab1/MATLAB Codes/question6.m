imc = imread('im1.png');% Read the image
img = rgb2gray(imc); % Convert to grayscale. 
imshow(img); % View image


theta = -.13*pi;
R = [cos(theta) sin(theta) 0; ...
-sin(theta) cos(theta) 0; ...
0 0 1];

[y_max, x_max] = size(img); % Obtaining the size of the image
corners = [0,0,1; ...
x_max,0,1; ...
0,y_max,1; ...
x_max,y_max,1]; % Corner points of the image
new_corners = corners*R % New location of corners
new_width = round(max(new_corners(:,1)) - ...
min(new_corners(:,1)));
new_height = round(max(new_corners(:,2)) - ...
min(new_corners(:,2)));
new_img = zeros(new_height,new_width);
min_width = abs(min(new_corners(:,1)));
min_height = abs(min(new_corners(:,2)));
min_width = round(min_width)+1;
min_height = round(min_height)+1;
rot_img = zeros(new_height,new_width);
for i = 1:new_height
for j = 1:new_width
temp = ([j-min_width i-min_height 1])/R;
x_new = round(temp(1,1));
y_new = round(temp(1,2));
if (x_new>0 && x_new< x_max)&& (y_new > 0 && y_new < y_max)
    rot_img(i,j)=img(y_new,x_new);
else
    rot_img(i,j)=0;


  end
 end
end
figure,imshow(rot_img,[]);
title('Rotated and Noise Free Image');

