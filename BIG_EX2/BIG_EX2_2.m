for i=1:50
    name=num2str(i);
    filename = strcat('实验2_3_TableTennis\stennisball',name,'.bmp');
    image=imread(filename);%读取前50帧图像
    image = rgb2gray(image);
    new_img = f_sobel_edge(image,150);
end
