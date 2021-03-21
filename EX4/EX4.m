%% ͼ������
clc;
clear;
close all;
img = imread('C.jpg');

%% ����ͼ������
%��������
img_salt_pepper = imnoise(img ,'salt & pepper',0.02); 

%��˹����
img_gaussian  = imnoise(img,'gaussian',0,0.1);

%��������
img_poisson = imnoise(img,'poisson');

figure
subplot(221)
imshow(img)
title('ԭͼ');
subplot(222)
imshow(img_salt_pepper)
title('���뽷���������ͼ��');
subplot(223)
imshow(img_gaussian)
title('�����˹�������ͼ��');
subplot(224)
imshow(img_poisson)
title('���벴���������ͼ��');
%% ��ֵ�˲�
figure
subplot(121)
imshow(img_gaussian)
title('�����˹�������ͼ��');
subplot(122)
imshow(f_Median(img_gaussian))
title('�Ը�˹����������ֵ�˲���ͼ��');

figure
subplot(121)
imshow(img_salt_pepper)
title('���뽷���������ͼ��');
subplot(122)
imshow(f_Median(img_salt_pepper))
title('�Խ�������������ֵ�˲���ͼ��');

figure
subplot(121)
imshow(img_poisson)
title('���벴���������ͼ��');
subplot(122)
imshow(f_Median(img_poisson))
title('�Բ�������������ֵ�˲���ͼ��');

%% �ݶ�����
%Prewitt ����
figure
subplot(121)
imshow(img)
title('ԭͼ');
subplot(122)
imshow(f_Prewitt(img))
title('����Prewitt������֮���ͼ��');

%sobel ����
figure
subplot(121)
imshow(img)
title('ԭͼ');
subplot(122)
imshow(f_sobel(img))
title('����Sobel������֮���ͼ��');
%% �˲�
%�����ͨ�˲�
figure
subplot(121)
imshow(img)
title('ԭͼ');
subplot(122)
imshow(f_ILPF(img,30))
title('���������ͨ�˲�֮���ͼ��');

%������˹��ͨ�˲�
figure
subplot(121)
imshow(img)
title('ԭͼ');
subplot(122)
imshow(f_Butterworth(img,15,2))
title('����������˹��ͨ�˲�֮���ͼ��');