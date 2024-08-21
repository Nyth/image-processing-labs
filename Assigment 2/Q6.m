% Read the image file 'moonlanding.png' 
img = imread('moonlanding.png');

% Perform the 2-dimensional Fast Fourier Transform (FFT) on the image matrix img
fft_img = fft2(img);

% Shift the zero-frequency component to the center of the Fourier Transform
fft_shifted = fftshift(fft_img);

% Compute the magnitude of the Fourier Transform and apply logarithmic scaling to enhance visibility
fft_mag = log(1 + abs(fft_shifted));

% Calculate the maximum value in the frequency spectrum
max_freq = max(fft_shifted(:));

% Display the magnitude of the Fourier Transform as an image with automatic scaling and add a title
figure, imshow(fft_mag, []), title('Fourier Transformation of Original');

% Shift the noisy Fourier transform image to center the zero-frequency component
fft_noise_centered = fftshift(noisy_fft);

% Perform the inverse 2-dimensional Fast Fourier Transform to convert back to the spatial domain
spatial_img = real(ifft2(fft_noise_centered));

% Display the noisy image in the spatial domain with automatic scaling and add a title
figure, imshow(spatial_img, []), title('Image with noise in spatial domain');

% Perform the 2-dimensional Fast Fourier Transform on the noisy spatial domain image
fft_spatial = fft2(spatial_img);

% Shift the zero-frequency component to the center of the Fourier Transform of the noisy spatial image
fft_shifted_spatial = fftshift(fft_spatial);

% Compute the magnitude of the Fourier Transform and apply logarithmic scaling to enhance visibility
fft_mag_spatial = log(1 + abs(fft_shifted_spatial));

% Display the magnitude of the Fourier Transform as an image with automatic scaling and add a title
figure, imshow(fft_mag_spatial, []), title('Fourier Transformation of image with noise from spatial domain');

% Define the cutoff frequency and the bandwidth for the filters
cutoff_freq = 100;
bandwidth = 8;

% Get the size of the Fourier transform magnitude image
[rows, cols] = size(fft_mag_spatial);

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
       butterworth_filter(i, j) = 1 / (1 + (distance * bandwidth / (distance^2 - cutoff_freq^2)^2 * order));
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
       gaussian_filter(i, j) = 1 - exp(-((distance^2 - cutoff_freq^2) / distance * bandwidth)^2);
   end
end

% Display the ideal filter
figure, imshow(ideal_filter), title('Ideal');

% Display the Butterworth filter with order n=4
figure, imshow(butterworth_filter), title('Butterworth');

% Display the Gaussian filter
figure, imshow(gaussian_filter), title('Gaussian');
