clc;
clear;
for i=1:50
    name=num2str(i);
    filename = strcat('实验2_3_TableTennis\stennisball',name,'.bmp');
    image=imread(filename);%读取前50帧图像
    I=im2bw(image,220/255);%对图像自动二值化
    [m,n]=size(I);%读取图像的大小
    M=zeros(m,n);%M矩阵用于选取乒乓球运动区域
    length=180;
    if i>=40
        length=190-i*2+30;
    end
    for k=74:155
        for j=1:length
            M(j,k)=1;
        end
    end
    I=I.*M;%去除桌子及左边白色区域的干扰
    f=bwareaopen(I,30);%去掉图像中面积小于30的点（去除手对识别的影响）   
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
            if L(ii,jj)>=1
                sum_x=sum_x+ii;
                sum_y=sum_y+jj;
                area=area+1;
            end
        end
    end
    
    %质心坐标
    plot_x(1)=fix(sum_x/area);
    plot_y(1)=fix(sum_y/area);
    imshow(image);
    
    %用曲率为1的矩形画圆
    if i>=40
        rectangle('Position',[plot_y(1)-8,plot_x(1)-8,24-8,24-8],'Curvature',[1,1],'linewidth',2),axis equal%圈出乒乓球区域
    else
        rectangle('Position',[plot_y(1)-12,plot_x(1)-12,24,24],'Curvature',[1,1],'linewidth',2),axis equal%圈出乒乓球区域
    end
    pause(0.05);%连续播放图片

end
