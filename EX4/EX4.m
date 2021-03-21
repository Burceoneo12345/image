%% 图像输入
clc;
clear;
close all;
img = imread('C.jpg');

%% 噪声图像生成
%椒盐噪声
img_salt_pepper = imnoise(img ,'salt & pepper',0.02); 

%高斯噪声
img_gaussian  = imnoise(img,'gaussian',0,0.1);

%泊松噪声
img_poisson = imnoise(img,'poisson');

figure
subplot(221)
imshow(img)
title('原图');
subplot(222)
imshow(img_salt_pepper)
title('加入椒盐噪声后的图像');
subplot(223)
imshow(img_gaussian)
title('加入高斯噪声后的图像');
subplot(224)
imshow(img_poisson)
title('加入泊松噪声后的图像');
%% 中值滤波
figure
subplot(121)
imshow(img_gaussian)
title('加入高斯噪声后的图像');
subplot(122)
imshow(f_Median(img_gaussian))
title('对高斯噪声进行中值滤波的图像');

figure
subplot(121)
imshow(img_salt_pepper)
title('加入椒盐噪声后的图像');
subplot(122)
imshow(f_Median(img_salt_pepper))
title('对椒盐噪声进行中值滤波的图像');

figure
subplot(121)
imshow(img_poisson)
title('加入泊松噪声后的图像');
subplot(122)
imshow(f_Median(img_poisson))
title('对泊松噪声进行中值滤波的图像');

%% 梯度算子
%Prewitt 算子
figure
subplot(121)
imshow(img)
title('原图');
subplot(122)
imshow(f_Prewitt(img))
title('经过Prewitt算子锐化之后的图像');

%sobel 算子
figure
subplot(121)
imshow(img)
title('原图');
subplot(122)
imshow(f_sobel(img))
title('经过Sobel算子锐化之后的图像');
%% 滤波
%理想低通滤波
figure
subplot(121)
imshow(img)
title('原图');
subplot(122)
imshow(f_ILPF(img,30))
title('经过理想低通滤波之后的图像');

%巴特沃斯高通滤波
figure
subplot(121)
imshow(img)
title('原图');
subplot(122)
imshow(f_Butterworth(img,15,2))
title('经过巴特沃斯高通滤波之后的图像');