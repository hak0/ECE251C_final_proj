function [] = Test(input_path, level, wname)
%level = 2
%wname = sym4
%input_path =  "# O-HAZY NTIRE 2018/hazy/";

if strcmp(input_path, "SOTS/indoor/hazy/")
    path_list = dir(strcat("../dataset/",input_path,"*_10.png"));
elseif strcmp(input_path, "SOTS/outdoordoor/hazy/")
    path_list = dir(strcat("../dataset/",input_path,"*.png"));
else
    path_list = dir(strcat("../dataset/",input_path,"*.jpg"));
end
out_path = "../opc_output/"+string(level)+"/"+string(wname)+"/"+input_path;
mkdir(out_path)

parfor i =1:length(path_list)
    fileName = path_list(i).name;
    filePath =  path_list(i).folder;
    fileImage = strcat(filePath,"\",fileName);
    distImage = strcat(out_path,"\",fileName);
    I = im2double(imread(fileImage));
    dehaze = totaldehaze(I, level, wname);
    img_d = imageFit(dehaze,[0.001, 0.999]);
    
    imwrite(img_d,distImage);
end
