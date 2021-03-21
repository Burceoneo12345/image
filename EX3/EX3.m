clc;
close all;
clear;
img = imread('image1.jpeg');
img = double(img);
[h,w,l] = size(img);
%% 对数处理
C = 2;
% 对数增强，old_img为原图像，C为尺寸比例常数
s = mat2gray(img,[0 255]);
new_log_img = mat2gray(C*log(1+double(s)),[0 1]);
figure
subplot(1,2,1)
imshow(uint8(img));
title('原图');
subplot(1,2,2)
imshow(new_log_img,[0,1]);
title('对数处理后图像');

%% 指数处理
a=50;
b=2;
c=0.04;
new_exp_img=b.^(c*(img-a))-1;
figure
subplot(1,2,1)
imshow(uint8(img));
title('原图');
subplot(1,2,2)
imshow(uint8(new_exp_img));
title('指数处理后图像');

%% 直方图
%直方图均衡化增强
[row,col,ll]=size(img);
new_balance_img=double(img);
img_temp=zeros(row,col,ll);
l=row*col;
temp1=zeros(1,256);
temp2=zeros(1,256);

for a = 1 : ll
    for i=1:row
        for j=1:col
            temp1(new_balance_img(i,j,a)+1)=temp1(new_balance_img(i,j,a)+1)+1;%存储各个灰度级的点总数放在temp1里
        end
    end
    %得到各灰度级的比例
    temp1=temp1/l;
    %求累积的直方图
    for k=1:256
        for j=1:k
            temp2(k)=temp2(k)+temp1(j);
        end
        temp2(k)=ceil(255*temp2(k));
    end
    for i=1:row
        for j=1:col
            img_temp(i,j,a)=temp2(new_balance_img(i,j,a)+1);
        end
    end
end
new_balance_img=uint8(img_temp);
figure
subplot(1,2,1)
imshow(uint8(img));
title('原图');
subplot(1,2,2)
imshow(uint8(new_balance_img));
title('直方图均衡化后图像');