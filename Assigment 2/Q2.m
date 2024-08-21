clc; clear all; close all;

% Read the image file 'moonlanding.png'
img = imread('moonlanding.png');

% Convert the image to double precision for FFT
img_double = double(img);

% Perform the 2-dimensional Fast Fourier Transform (FFT) on the image
fft_img = fft2(img_double);

% Shift the zero-frequency component to the center of the Fourier Transform
fft_shifted = fftshift(fft_img);

% Compute the magnitude of the Fourier Transform
fft_mag = abs(fft_shifted);

% Calculate the maximum value of the frequency spectrum
FSmax = max(fft_mag(:));

% Display the magnitude of the Fourier Transform as an image with automatic scaling and add a title
figure, imshow(log(1 + fft_mag), []), title('Frequency Spectrum');

% Display the maximum value of the frequency spectrum
disp(['Maximum value of the frequency spectrum: ', num2str(FSmax)]);
