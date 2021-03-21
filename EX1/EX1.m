clear;
clc;
close all;
I1=imread('image1.jpeg');
imwrite(I1,'result.png');
I2 = rgb2gray(I1);  
[X,map] = rgb2ind(I1,256); 
I3 = imbinarize(I2);
S = imfinfo('image1.jpeg');
figure
subplot(2,2,1)
imshow(I1)
title('真彩色图像');
% imwrite(I1,'真彩色图像.jpg');
subplot(2,2,2)
imshow(I2)
title('灰度图像');
% imwrite(I2,'灰度图像.jpg');
subplot(2,2,3)
imshow(X,map)
title('索引图像');
% imwrite(X,'索引图像.jpg');
subplot(2,2,4)
imshow(I3)
title('二值化图像');
% imwrite(I3,'二值化图像.jpg');


%%

%%
figure
A = imread('image1.jpeg');
subplot(321),imshow(A);title('原图');
% 1.rgb到灰度
B = rgb2gray(A);
subplot(322),imshow(B);title('rgb到灰度');
% 2.灰度到二值
C = imbinarize(B);
subplot(323),imshow(C);title('灰度到二值');
% 3.rgb到索引
[D,map] = rgb2ind(A,150);
subplot(324),imshow(D,map);title('rgb到索引');
% 4.索引到rgb
E = ind2rgb(D,map);
subplot(325),imshow(E);title('索引到rgb');
% 5.索引到灰度
F = ind2gray(D,map);
subplot(326),imshow(F);title('索引到灰度');

