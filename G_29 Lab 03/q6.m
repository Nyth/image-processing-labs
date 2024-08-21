% Group - 29
%Members: Kazi Salith Ur Rahman & Nayem Al Tareq

F_rgb = imread('puppy.jpg');
F = rgb2gray(F_rgb);
im_size = size(F);
P = 2 * im_size(1);
Q = 2 * im_size(2);
FTIm = fft2(double(F), P, Q);
FTIm_shifted = fftshift(FTIm);
cutoffs = [0.1, 0.3, 0.5, 0.7] * im_size(1);
orders = [1, 5, 20];
figure;
subplot_counter = 1;
function applyFilter(type, method, cutoff, n, subplot_counter, P, Q, FTIm_shifted, F, im_size)
   Filter = lp_hp_filters(type, method, P, Q, cutoff, n);
   Filtered_FT = Filter .* FTIm_shifted;
   Filtered_image = real(ifft2(ifftshift(Filtered_FT)));
   Filtered_image = Filtered_image(1:im_size(1), 1:im_size(2));
   subplot(6, 4, subplot_counter), imshow(F, []), title('Original Image');
   subplot(6, 4, subplot_counter + 1), imshow(log(1+abs(fftshift(FTIm_shifted))), []), title('FT of Original');
   subplot(6, 4, subplot_counter + 2), imshow(log(1+abs(fftshift(Filter))), []), title(['Filter: ', type, ' ', method]);
   subplot(6, 4, subplot_counter + 3), imshow(Filtered_image, []), title('Filtered Image');
end
for cutoff = [0.3, 0.7] * im_size(1)
   applyFilter('ideal', 'lp', cutoff, 0, subplot_counter, P, Q, FTIm_shifted, F, im_size);
   subplot_counter = subplot_counter + 4;
end
for cutoff = [0.1, 0.5] * im_size(1)
   for order = orders
       applyFilter('btw', 'lp', cutoff, order, subplot_counter, P, Q, FTIm_shifted, F, im_size);
       subplot_counter = subplot_counter + 4;
   end
end
for cutoff = [0.1, 0.3, 0.7] * im_size(1)
   applyFilter('gaussian', 'lp', cutoff, 0, subplot_counter, P, Q, FTIm_shifted, F, im_size);
   subplot_counter = subplot_counter + 4;
end
for cutoff = [0.1, 0.3, 0.7] * im_size(1)
   applyFilter('ideal', 'hp', cutoff, 0, subplot_counter, P, Q, FTIm_shifted, F, im_size);
   subplot_counter = subplot_counter + 4;
end

Butterworth high pass filters
for cutoff = [0.1, 0.5] * im_size(1)
   for order = orders
       applyFilter('btw', 'hp', cutoff, order, subplot_counter, P, Q, FTIm_shifted, F, im_size);
       subplot_counter = subplot_counter + 4;
   end
end

%Gaussian high pass filters
for cutoff = [0.1, 0.3, 0.7] * im_size(1)
   applyFilter('gaussian', 'hp', cutoff, 0, subplot_counter, P, Q, FTIm_shifted, F, im_size);
   subplot_counter = subplot_counter + 4;
end
