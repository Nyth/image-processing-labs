% Apply rotation (T3) to Im1
Im4 = imtransform(Im1, T3, 'XData', [-269 M - 270], 'YData', [111 N + 110]);
imshow(Im4);
title('Rotated Image 45 Degrees (Im4)');
