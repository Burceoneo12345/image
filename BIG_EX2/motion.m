clc;
u = rgb2gray(imread('./实验2_3_TableTennis/stennisball0.bmp'));
background = zeros(size(u));
background = background + double(u);

alpha = 0.6;

for i = 1:34
    img = rgb2gray(imread(['./实验2_3_TableTennis/stennisball', num2str(i), '.bmp']));
    background = background + double(img);
end
background = background / 35;
background = uint8(background);
imwrite(background, 'background.jpg');
% figure(1);imshow(background);

for i = 0:10
    img = imread(['./实验2_3_TableTennis/stennisball', num2str(i), '.bmp']);
    I = abs(rgb2gray(img) - background);
    shape = size(I);
    for m = 1:shape(1)
        for n = 1:shape(2)
            if(I(m,n) > 80)
                I(m,n) = 255;
            else
                I(m,n) = 0;
            end
        end
    end
    I = uint8(I);
    f = bwareaopen(I, 50);
    se=strel('disk',2);%创建一个半径为2的圆形结构元素
    I1=imdilate(f,se);%用结构元素se对图像作膨胀运算
    [L,num]=bwlabel(I1,8);%标注二进制图像中已连接的部分
    
    plot_x=zeros(1,1);%用于记录质心位置的坐标
    plot_y=zeros(1,1);
    %找质心
    sum_x=0;sum_y=0;area=0;
    [height,width]=size(I1);
    for ii=1:height
        for jj=1:width
            if L(ii,jj)==1
                sum_x=sum_x+ii;
                sum_y=sum_y+jj;
                area=area+1;
            end
        end
    end
    
    %质心坐标
    plot_x(1)=fix(sum_x/area);
    plot_y(1)=fix(sum_y/area);
    figure(2);imshow(img);
    %用曲率为1的矩形画圆
    if i>=40
        rectangle('Position',[plot_y(1)-7,plot_x(1)-7,24-7,24-7],'Curvature',[1,1],'linewidth',1),axis equal%圈出乒乓球区域
    else
        rectangle('Position',[plot_y(1)-12,plot_x(1)-12,24,24],'Curvature',[1,1],'linewidth',1),axis equal%圈出乒乓球区域
    end
    
    pause(0.05);
end
