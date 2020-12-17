function d = totaldehaze(f, level, wname)
%level: wavelet level, default: 2;
%wname: wavelet filter name, default: sym4

coef = 2^level;

[C,S] = wavedec2(f,level,wname);
det1 = detcoef2('compact',C,S,1);
tau = median(abs(det1))/0.6745;


A = appcoef2(C,S,wname,level);
[imD,t]= dehazing(A/coef,level); 
NA=  (imD(:)*coef)';

for n = level:-1:1
    [CHD,CVD,CDD] = detcoef2('all',C,S,n);
    t = imresize(t,[size(CHD,1),size(CHD,2)],'bicubic');
   
    % tD = cat(3,t,t,t);
    CHD = wthresh(CHD,'s',tau);             
    CVD = wthresh(CVD,'s',tau);              
    CDD = wthresh(CDD,'s',tau);             
   
    NCHD = bsxfun(@rdivide,CHD,t);           
    NCVD = bsxfun(@rdivide,CVD,t);           
    NCDD = bsxfun(@rdivide,CDD,t);          
  
    NA = [NA NCHD(:)' NCVD(:)' NCDD(:)'];
end

d = waverec2(NA,S,wname);
d(d>1) = 1;
d(d<0) = 0;