tic % timing function
imc = imread('im1.png'); % Read the image 
img = rgb2gray(imc); 
% Convert to grayscale. The supplied image is a grayscale, so you don't need to use this step. 
%imshow(img); % View image

theta = 0.5*pi; %90 deg rotation
R = [cos(theta) sin(theta) 0; ... 
-sin(theta) cos(theta) 0; ... 
0 0 1];

%inbluilt Function to transform with rotation
tform = maketform("affine",R);
img = imtransform(img,tform);
imshow(img)
toc