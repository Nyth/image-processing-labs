% Load the original image
Im1 = imread('image.png');

% Check if the image is already in grayscale or not
if size(Im1, 3) == 3  % The image is RGB (has three channels)
    Im1 = rgb2gray(Im1);  % Convert to grayscale
end

% Get the size of the original image
[M, N] = size(Im1);

% Pad the image with zeros (one-fourth the size in each direction)
pad_size = round([M, N] / 4);
Im1_padded = padarray(Im1, pad_size, 0, 'both');

% Display the padded image
imshow(Im1_padded);
title('Padded Image (Im1)');
