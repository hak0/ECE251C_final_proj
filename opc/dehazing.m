function [res, t,x]= dehazing(I,level)

dark = imopen(min(I, [], 3), strel('square', 8));
isize = size(I,2) * size(I,1);


[~, index] = sort(reshape(dark,isize,1)); 
index = index(isize-max(floor(isize/1000),1)+1:end); 

xtotal = zeros(1,3);
c = reshape(I,isize,3);  
for i = 1:max(floor(isize/1000),1)
    xtotal = xtotal + c(index(i),:);
end

A = xtotal / max(floor(isize/1000),1);

im3 = zeros(size(I));
for i = 1:3 
    im3(:,:,i) = I(:,:,i)./A(i);
end

transmission = 1-0.95*imopen(min(im3, [], 3),strel('square', 15));
x=transmission;
jointImg = rgb2gray(I);
d = 2.^level;
r=ceil(30/d);
[hei, wid] = size(jointImg);
N = boxfiltering(ones(hei, wid), r); 
mean_I = boxfiltering(jointImg, r) ./ N;
mean_p = boxfiltering(transmission, r) ./ N;
mean_Ip = boxfiltering(jointImg.*transmission, r) ./ N;
cov_Ip = mean_Ip - mean_I .* mean_p;

mean_II = boxfiltering(jointImg.*jointImg, r) ./ N;
var_I = mean_II - mean_I .* mean_I;

a = cov_Ip ./ (var_I + 0.0001); 
b = mean_p - a .* mean_I; 

mean_a = boxfiltering(a, r) ./ N;
mean_b = boxfiltering(b, r) ./ N;
transmission = mean_a .* jointImg + mean_b;
t= rfTransform(transmission,10,0.1,3,jointImg);
res = zeros(size(I));
    
tran = max(rfTransform(transmission,10,0.1,3,jointImg),0.3);
    
res(:,:,1) = (I(:,:,1) - A(1))./tran + A(1);
res(:,:,2) = (I(:,:,2) - A(2))./tran + A(2);
res(:,:,3) = (I(:,:,3) - A(3))./tran + A(3);



end
