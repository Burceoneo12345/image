clc;clear;close all;
%% 自动阈值
A = imread('C.png');
H1=auto_T(A);
figure;
subplot(121),imshow(A);title('原始图像');
subplot(122),imshow(H1);title('迭代法自动阈值');
%% 分水岭
A = rgb2gray(imread('5_test1.png'));
H1=watershed_test(A);
figure;
subplot(121),imshow(A);title('原始图像');
subplot(122),imshow(H1);title('分水岭');
%% Roberts、Sobel、Prewitt边缘检测算子分割
%A = imread('cameraman.tif');
% Roberts边缘检测算子
H2 = f_roberts_edge(A,50);
subplot(121),imshow(A);title('原始图像'); % 原图显示
subplot(122),imshow(H2);title('Roberts边缘检测') % Roberts边缘检测
figure;
% Sobel边缘检测算子
H3 = f_sobel_edge(A,200);
subplot(121),imshow(A);title('原始图像'); % 原图显示
subplot(122),imshow(H3);title('Sobel边缘检测') % Sobel边缘检测
figure;
% Prewitt边缘检测算子
H4 = f_Prewitt_edge(A,200);
subplot(121),imshow(A);title('原始图像'); % 原图显示
subplot(122),imshow(H4);title('Prewitt边缘检测') % Prewitt边缘检测
%% 二值图像边界跟踪
B = imread('5_test.png');
B = rgb2gray(B);
B = imbinarize(B);
H4 = f_boundary_trace(B,10,10);
figure;
subplot(121),imshow(B);title('原始图像');
subplot(122),imshow(H4);title('二值图像边界跟踪');