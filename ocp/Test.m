input_path =  '# O-HAZY NTIRE 2018/hazy/';
path_list = dir(strcat(input_path,'*.jpg'));
out_path = 'output/O-HAZY/';

for i =1:length(path_list)
    fileName = path_list(i).name;
    filePath =  path_list(i).folder;
    fileImage = strcat(filePath,'\',fileName);
    distImage = strcat(out_path,'\',fileName);
    I = im2double(imread(fileImage));
    dehaze = totaldehaze(I);
    img_d = imageFit(dehaze,[0.001, 0.999]);
    
    imwrite(img_d,distImage);
    
end
