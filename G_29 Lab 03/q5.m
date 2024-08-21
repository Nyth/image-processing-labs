% Group - 29
%Members: Kazi Salith Ur Rahman & Nayem Al Tareq

F_rgb = imread('puppy.jpg');
F = rgb2gray(F_rgb);
im_size = size(F);
P = 2 * im_size(1);  
Q = 2 * im_size(2); 
FTIm = fft2(double(F), P, Q); 
FTIm_shifted = fftshift(FTIm);
Filter_type = 'ideal';    
lp_or_hp = 'lp';         
D0 = 0.1 * im_size(1);    
n = 0;                 
Filter = lp_hp_filters(Filter_type, lp_or_hp, P, Q, D0, n);
Filtered_FT = FTIm_shifted .* Filter;
Filtered_image = ifft2(ifftshift(Filtered_FT));
Filtered_image = real(Filtered_image);
figure;
imshow(F);
title('---Original Grayscale Image---');
figure;
imshow(log(1 + abs(FTIm_shifted)), []);
title('---Magnitude Spectrum of Fourier Transform---');
figure;
imshow(Filter, []);
title(['Filter: ', Filter_type, ' ', lp_or_hp, ' pass']);
figure;
imshow(Filtered_image, []);
title('---Filtered Image---');
