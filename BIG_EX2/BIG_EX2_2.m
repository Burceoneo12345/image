for i=1:50
    name=num2str(i);
    filename = strcat('ʵ��2_3_TableTennis\stennisball',name,'.bmp');
    image=imread(filename);%��ȡǰ50֡ͼ��
    image = rgb2gray(image);
    new_img = f_sobel_edge(image,150);
end
