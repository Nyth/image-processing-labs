clc; clear all; close all;

% Read the image file 'moonlanding.png'
img = imread('moonlanding.png');

% Convert the image to double precision for FFT
img_double = double(img);

% Perform the 2-dimensional Fast Fourier Transform (FFT) on the image
fft_img = fft2(img_double);

% Shift the zero-frequency component to the center of the Fourier Transform
centered_fft_image = fftshift(fft_img);

% Compute the magnitude of the Fourier Transform
fft_mag = abs(centered_fft_image);

% Calculate the maximum value of the frequency spectrum
max_frequency_value = max(fft_mag(:));

% Get the size of the centered Fourier transform image
[rows, cols] = size(centered_fft_image);

% Calculate the center coordinates of the image
center = [rows / 2, cols / 2];

% Define the distance for the noise points from the center
dist = 100;

% Define the angle in radians for diagonal points
angle = pi / 4;

% Reduce the maximum frequency spectrum value to introduce noise
new_max_freq = max_frequency_value / 10;

% Define the coordinates for the points in the north, east, south, and west directions
N = [center(1) - dist, center(2)];
E = [center(1), center(2) + dist];
S = [center(1) + dist, center(2)];
W = [center(1), center(2) - dist];

% Define the coordinates for the diagonal points (northeast, northwest, southeast, southwest)
NE = [round(center(1) - (sin(angle) * dist)), round(center(2) + (cos(angle) * dist))];
NW = [round(center(1) - (sin(angle) * dist)), round(center(2) - (cos(angle) * dist))];
SE = [round(center(1) + (sin(angle) * dist)), round(center(2) + (cos(angle) * dist))];
SW = [round(center(1) + (sin(angle) * dist)), round(center(2) - (cos(angle) * dist))];

% Copy the original centered Fourier transform image to add noise
noisy_fft = centered_fft_image;

% Define a placeholder function for adding noise; replace 'noise_func' with the actual function name
% noise_func should be a function that adds noise to the specific point in the frequency domain

for idx = 1:8
   % Combine all the points into a matrix
   points = [N; E; S; W; NE; NW; SE; SW];
   
   % Select the current point
   point = points(idx, :);
   
   % Apply manual noise to the selected point in the Fourier transform image
   % You need to replace 'noise_func' with the actual noise-adding function
   noisy_fft = noise_func(noisy_fft, point, new_max_freq); % Replace 'manual_noise' with the actual function if different
end

% Compute the magnitude of the noisy Fourier transform and apply logarithmic scaling
noisy_fft_mag = log(1 + abs(noisy_fft));

% Display the noisy Fourier transform as an image with automatic scaling and add a title
figure, imshow(noisy_fft_mag, []), title('Fourier Transformation of image with noise');
