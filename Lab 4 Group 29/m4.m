% Apply translation (T1) to Im1
Im2 = imtransform(Im1, T1, 'XData', [1 N], 'YData', [1 M]);
imshow(Im2);
title('Translated Image (Im2)');
