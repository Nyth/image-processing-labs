function [result] = noise_func(img, point, noise)
% This function gets an image and desired point, 
% then apply noise(value) on the 3*3 neighboring pixels
for i = -1:1
    for j =-1:1
        img((point(1)+i), (point(2)+j)) = noise;
    end
end
result = img;
end

