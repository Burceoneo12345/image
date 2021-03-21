clc;clear;close all;
%% �Զ���ֵ
A = imread('C.png');
H1=auto_T(A);
figure;
subplot(121),imshow(A);title('ԭʼͼ��');
subplot(122),imshow(H1);title('�������Զ���ֵ');
%% ��ˮ��
A = rgb2gray(imread('5_test1.png'));
H1=watershed_test(A);
figure;
subplot(121),imshow(A);title('ԭʼͼ��');
subplot(122),imshow(H1);title('��ˮ��');
%% Roberts��Sobel��Prewitt��Ե������ӷָ�
%A = imread('cameraman.tif');
% Roberts��Ե�������
H2 = f_roberts_edge(A,50);
subplot(121),imshow(A);title('ԭʼͼ��'); % ԭͼ��ʾ
subplot(122),imshow(H2);title('Roberts��Ե���') % Roberts��Ե���
figure;
% Sobel��Ե�������
H3 = f_sobel_edge(A,200);
subplot(121),imshow(A);title('ԭʼͼ��'); % ԭͼ��ʾ
subplot(122),imshow(H3);title('Sobel��Ե���') % Sobel��Ե���
figure;
% Prewitt��Ե�������
H4 = f_Prewitt_edge(A,200);
subplot(121),imshow(A);title('ԭʼͼ��'); % ԭͼ��ʾ
subplot(122),imshow(H4);title('Prewitt��Ե���') % Prewitt��Ե���
%% ��ֵͼ��߽����
B = imread('5_test.png');
B = rgb2gray(B);
B = imbinarize(B);
H4 = f_boundary_trace(B,10,10);
figure;
subplot(121),imshow(B);title('ԭʼͼ��');
subplot(122),imshow(H4);title('��ֵͼ��߽����');