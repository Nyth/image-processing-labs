% Shift the noisy Fourier transform image to center the zero-frequency component
fft_noise_centered = fftshift(noisy_fft);

% Perform the inverse 2-dimensional Fast Fourier Transform to convert back to the spatial domain
spatial_img = real(ifft2(fft_noise_centered));

% Display the noisy image in the spatial domain with automatic scaling and add a title
figure, imshow(spatial_img, []), title('Image with noise in spatial domain');
