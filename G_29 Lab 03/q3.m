% Group - 29
%Members: Kazi Salith Ur Rahman & Nayem Al Tareq

F_rgb = imread('puppy.jpg');
F = rgb2gray(F_rgb);
figure;
imshow(F);
title('Grayscale Image for Puppy:');
im_size = size(F);
P = 2 * im_size(1); 
Q = 2 * im_size(2); 
disp(['Row: Padding size: ', num2str(P)]);
disp(['Column: Padding size: ', num2str(Q)]);