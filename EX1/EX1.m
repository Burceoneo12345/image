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
title('���ɫͼ��');
% imwrite(I1,'���ɫͼ��.jpg');
subplot(2,2,2)
imshow(I2)
title('�Ҷ�ͼ��');
% imwrite(I2,'�Ҷ�ͼ��.jpg');
subplot(2,2,3)
imshow(X,map)
title('����ͼ��');
% imwrite(X,'����ͼ��.jpg');
subplot(2,2,4)
imshow(I3)
title('��ֵ��ͼ��');
% imwrite(I3,'��ֵ��ͼ��.jpg');


%%

%%
figure
A = imread('image1.jpeg');
subplot(321),imshow(A);title('ԭͼ');
% 1.rgb���Ҷ�
B = rgb2gray(A);
subplot(322),imshow(B);title('rgb���Ҷ�');
% 2.�Ҷȵ���ֵ
C = imbinarize(B);
subplot(323),imshow(C);title('�Ҷȵ���ֵ');
% 3.rgb������
[D,map] = rgb2ind(A,150);
subplot(324),imshow(D,map);title('rgb������');
% 4.������rgb
E = ind2rgb(D,map);
subplot(325),imshow(E);title('������rgb');
% 5.�������Ҷ�
F = ind2gray(D,map);
subplot(326),imshow(F);title('�������Ҷ�');

