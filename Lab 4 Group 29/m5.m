% Apply scaling (T2) to Im1
Im3 = imtransform(Im1, T2, 'XData', [1 N], 'YData', [1 M]);
imshow(Im3);
title('Scaled Image (Im3)');
