% Perform the inverse 2-dimensional Fast Fourier Transform to convert the ideal filtered image back to the spatial domain
spatial_ideal = real(ifft2(img_ideal_filtered));

% Perform the inverse 2-dimensional Fast Fourier Transform to convert the Butterworth filtered image back to the spatial domain
spatial_butter = real(ifft2(img_butter_filtered));

% Perform the inverse 2-dimensional Fast Fourier Transform to convert the Gaussian filtered image back to the spatial domain
spatial_gaussian = real(ifft2(img_gaussian_filtered));

% Display the result of the ideal band reject filter in the spatial domain
figure, imshow(spatial_ideal, []), title('Ideal band reject filter in spatial domain');

% Display the result of the Butterworth band reject filter in the spatial domain
figure, imshow(spatial_butter, []), title('Butterworth band reject filter in spatial domain');

% Display the result of the Gaussian band reject filter in the spatial domain
figure, imshow(spatial_gaussian, []), title('Gaussian band reject filter in spatial domain');
