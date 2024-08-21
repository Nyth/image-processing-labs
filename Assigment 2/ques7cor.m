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

% Define the points matrix containing all noise points
points = [N; E; S; W; NE; NW; SE; SW];

% Add noise to each specified point in the Fourier transform image
for idx = 1:size(points, 1)
    point = points(idx, :);
    noisy_fft(point(1)-1:point(1)+1, point(2)-1:point(2)+1) = new_max_freq;
end

% Compute the magnitude of the noisy Fourier transform and apply logarithmic scaling
noisy_fft_mag = log(1 + abs(noisy_fft));

% Display the noisy Fourier transform as an image with automatic scaling and add a title
figure, imshow(noisy_fft_mag, []), title('Fourier Transformation of image with noise');

% Define the cutoff frequency and the bandwidth for the filters
cutoff_freq = 100;
bandwidth = 8;

% Initialize the ideal filter with ones
ideal_filter = ones(rows, cols);

% Calculate the center coordinates of the filter
center_x = round(rows / 2);
center_y = round(cols / 2);

% Create the ideal bandstop filter
for i = 1:rows
    for j = 1:cols
        % Calculate the distance from the center
        dist_x = i - center_x;
        dist_y = j - center_y;
        distance = sqrt(dist_x^2 + dist_y^2);
        
        % Apply the ideal bandstop filter condition
        if (cutoff_freq - bandwidth / 2) <= distance && distance <= (cutoff_freq + bandwidth / 2)
            ideal_filter(i, j) = 0;
        end
    end
end

% Initialize the Butterworth filter with ones
butterworth_filter = ones(rows, cols);

% Define the order of the Butterworth filter
order = 4;

% Create the Butterworth bandstop filter
for i = 1:rows
    for j = 1:cols
        % Calculate the distance from the center
        dist_x = i - center_x;
        dist_y = j - center_y;
        distance = sqrt(dist_x^2 + dist_y^2);
        
        % Apply the Butterworth bandstop filter formula
        butterworth_filter(i, j) = 1 / (1 + ((distance^2 - cutoff_freq^2) / (distance * bandwidth))^(2 * order));
    end
end

% Initialize the Gaussian filter with ones
gaussian_filter = ones(rows, cols);

% Create the Gaussian bandstop filter
for i = 1:rows
    for j = 1:cols
        % Calculate the distance from the center
        dist_x = i - center_x;
        dist_y = j - center_y;
        distance = sqrt(dist_x^2 + dist_y^2);
        
        % Apply the Gaussian bandstop filter formula
        gaussian_filter(i, j) = 1 - exp(-((distance^2 - cutoff_freq^2)^2 / (distance * bandwidth)^2));
    end
end

% Apply the ideal band reject filter to the noisy Fourier transform image
img_ideal_filtered = noisy_fft .* ideal_filter;

% Apply the Butterworth band reject filter to the noisy Fourier transform image
img_butter_filtered = noisy_fft .* butterworth_filter;

% Apply the Gaussian band reject filter to the noisy Fourier transform image
img_gaussian_filtered = noisy_fft .* gaussian_filter;

% Display the result of applying the ideal band reject filter in the frequency domain
figure, imshow(log(1 + abs(img_ideal_filtered)), []), title('Ideal band reject filter in frequency domain');

% Display the result of applying the Butterworth band reject filter in the frequency domain
figure, imshow(log(1 + abs(img_butter_filtered)), []), title('Butterworth band reject filter in frequency domain');

% Display the result of applying the Gaussian band reject filter in the frequency domain
figure, imshow(log(1 + abs(img_gaussian_filtered)), []), title('Gaussian band reject filter in frequency domain');

% Convert the filtered images back to the spatial domain
ideal_spatial = real(ifft2(ifftshift(img_ideal_filtered)));
butter_spatial = real(ifft2(ifftshift(img_butter_filtered)));
gaussian_spatial = real(ifft2(ifftshift(img_gaussian_filtered)));

% Display the results of applying the filters in the spatial domain
figure, imshow(ideal_spatial, []), title('Ideal Band-Reject Filter Result');
figure, imshow(butter_spatial, []), title('Butterworth Band-Reject Filter Result');
figure, imshow(gaussian_spatial, []), title('Gaussian Band-Reject Filter Result');
