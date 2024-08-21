% Read the Image
Im = imread('image.png');
if size(Im, 3) == 3  % Convert to grayscale if necessary
    Im = rgb2gray(Im);
end

% Get the size of the original image
[M, N] = size(Im);

% Display the original image
figure;
imshow(Im);
title('Original Image');

% Calculate translation values (one-fourth of the image size)
Xt = N / 4;
Yt = M / 4;

% Translation Matrix T1
T1 = maketform('affine', [1 0 0; 0 1 0; Xt Yt 1]);
Im2 = imtransform(Im, T1, 'XData', [1 N], 'YData', [1 M]);
disp('Transformation Matrix T1 (Translation):');
disp(T1.tdata.T);

% Display Translated Image
figure;
imshow(Im2);
title('Translated Image (Im2)');

% Scaling Matrix T2 (Scaling to 0.5 of original size)
T2 = maketform('affine', [0.5 0 0; 0 0.5 0; 0 0 1]);
Im3 = imtransform(Im, T2, 'XData', [1 N], 'YData', [1 M]);
disp('Transformation Matrix T2 (Scaling):');
disp(T2.tdata.T);

% Display Scaled Image
figure;
imshow(Im3);
title('Scaled Image (Im3)');

% Rotation Matrix T3 (45 degrees)
T3 = maketform('affine', [cos(pi/4) sin(pi/4) 0; -sin(pi/4) cos(pi/4) 0; 0 0 1]);
Im4 = imtransform(Im, T3, 'XData', [-269 N - 270], 'YData', [111 M + 110]);
disp('Transformation Matrix T3 (45 degrees rotation):');
disp(T3.tdata.T);

% Display Rotated Image (45 degrees)
figure;
imshow(Im4);
title('Rotated Image 45 Degrees (Im4)');

% Rotation Matrix T4 (90 degrees)
T4 = maketform('affine', [cos(pi/2) sin(pi/2) 0; -sin(pi/2) cos(pi/2) 0; 0 0 1]);
Im5 = imtransform(Im, T4, 'XData', [-539 N - 540], 'YData', [1 M]);
disp('Transformation Matrix T4 (90 degrees rotation):');
disp(T4.tdata.T);

% Display Rotated Image (90 degrees)
figure;
imshow(Im5);
title('Rotated Image 90 Degrees (Im5)');
