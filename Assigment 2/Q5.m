% Perform the 2-dimensional Fast Fourier Transform on the noisy spatial domain image
fft_spatial = fft2(spatial_img);

% Shift the zero-frequency component to the center of the Fourier Transform of the noisy spatial image
fft_shifted_spatial = fftshift(fft_spatial);

% Compute the magnitude of the Fourier Transform and apply logarithmic scaling to enhance visibility
fft_mag_spatial = log(1 + abs(fft_shifted_spatial));

% Display the magnitude of the Fourier Transform as an image with automatic scaling and add a title
figure, imshow(fft_mag_spatial, []), title('Fourier Transformation of image with noise from spatial domain');
