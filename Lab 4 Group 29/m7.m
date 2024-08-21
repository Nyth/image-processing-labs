% Apply rotation (T4) to Im1
Im5 = imtransform(Im1, T4, 'XData', [-539 M - 540], 'YData', [1 N]);
imshow(Im5);
title('Rotated Image 90 Degrees (Im5)');
