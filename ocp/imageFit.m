function res = imageFit(I,P)
I=I-min(I(:))./max(I(:));
res = stretchlim(I,P);
res(1,:) = 0.2*res(1,:) + (1-0.2)*min(res(1,:), mean(res(1,:)));
res(2,:) = max(res(2,:), 0.2);
res(2,:) = 0.2*res(2,:) + (1-0.2)*max(res(2,:), mean(res(2,:)));
res=imadjust(I,res,[],1);
end
