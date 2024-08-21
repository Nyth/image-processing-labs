% Apply the ideal band reject filter to the noisy Fourier transform image
img_ideal_filtered = noisy_fft_mag .* ideal_filter;

% Apply the Butterworth band reject filter to the noisy Fourier transform image
img_butter_filtered = noisy_fft_mag .* butterworth_filter;

% Apply the Gaussian band reject filter to the noisy Fourier transform image
img_gaussian_filtered = noisy_fft_mag .* gaussian_filter;

% Display the result of applying the ideal band reject filter in the frequency domain
figure, imshow(img_ideal_filtered, []), title('Ideal band reject filter in frequency domain');

% Display the result of applying the Butterworth band reject filter in the frequency domain
figure, imshow(img_butter_filtered, []), title('Butterworth band reject filter in frequency domain');

% Display the result of applying the Gaussian band reject filter in the frequency domain
figure, imshow(img_gaussian_filtered, []), title('Gaussian band reject filter in frequency domain');