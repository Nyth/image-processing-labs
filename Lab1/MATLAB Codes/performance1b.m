imc = imread('im1.png'); % Read the image 
img = rgb2gray(imc); % Convert to grayscale. The supplied image is a grayscale, so you don't need to use this step. 

theta = 0.5*pi; 
R = [cos(theta) sin(theta) 0; ... 
-sin(theta) cos(theta) 0; ... 
0 0 1];
tform = maketform("affine",R);
img = imtransform(imc,tform);
imshow(img)
toc