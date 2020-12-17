function img = boxfiltering(I, r)
[x, y] = size(I);
img = zeros(size(I));
ims = cumsum(I, 1);
img(1:r+1, :) = ims(1+r:2*r+1, :);
img(r+2:x-r, :) = ims(2*r+2:x, :) - ims(1:x-2*r-1, :);
img(x-r+1:x, :) = repmat(ims(x, :), [r, 1]) - ims(x-2*r:x-r-1, :);
ims = cumsum(img, 2);
img(:, 1:r+1) = ims(:, 1+r:2*r+1);
img(:, r+2:y-r) = ims(:, 2*r+2:y) - ims(:, 1:y-2*r-1);
img(:, y-r+1:y) = repmat(ims(:, y), [1, r]) - ims(:, y-2*r:y-r-1);
end

