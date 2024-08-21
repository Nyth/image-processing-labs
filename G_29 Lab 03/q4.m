% Group - 29
%Members: Kazi Salith Ur Rahman & Nayem Al Tareq

F_rgb = imread('puppy.jpg');
F = rgb2gray(F_rgb);
im_size = size(F);
P = 2 * im_size(1); 
Q = 2 * im_size(2); 
FTIm = fft2(double(F), P, Q);
FTIm_shifted = fftshift(FTIm);
magnitudeSpectrum = log(1 + abs(FTIm_shifted));
figure;
imshow(magnitudeSpectrum, []);
title('---Magnitude Spectrum of Fourier Transform---');
figure;
imshow(F);
title('---Grayscale Image---');
disp(['Padding size for rows: ', num2str(P)]);
disp(['Padding size for columns: ', num2str(Q)]);