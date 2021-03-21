clc;
close all;
clear;
img = imread('image1.jpeg');
img = double(img);
[h,w,l] = size(img);
%% ��������
C = 2;
% ������ǿ��old_imgΪԭͼ��CΪ�ߴ��������
s = mat2gray(img,[0 255]);
new_log_img = mat2gray(C*log(1+double(s)),[0 1]);
figure
subplot(1,2,1)
imshow(uint8(img));
title('ԭͼ');
subplot(1,2,2)
imshow(new_log_img,[0,1]);
title('���������ͼ��');

%% ָ������
a=50;
b=2;
c=0.04;
new_exp_img=b.^(c*(img-a))-1;
figure
subplot(1,2,1)
imshow(uint8(img));
title('ԭͼ');
subplot(1,2,2)
imshow(uint8(new_exp_img));
title('ָ�������ͼ��');

%% ֱ��ͼ
%ֱ��ͼ���⻯��ǿ
[row,col,ll]=size(img);
new_balance_img=double(img);
img_temp=zeros(row,col,ll);
l=row*col;
temp1=zeros(1,256);
temp2=zeros(1,256);

for a = 1 : ll
    for i=1:row
        for j=1:col
            temp1(new_balance_img(i,j,a)+1)=temp1(new_balance_img(i,j,a)+1)+1;%�洢�����Ҷȼ��ĵ���������temp1��
        end
    end
    %�õ����Ҷȼ��ı���
    temp1=temp1/l;
    %���ۻ���ֱ��ͼ
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
title('ԭͼ');
subplot(1,2,2)
imshow(uint8(new_balance_img));
title('ֱ��ͼ���⻯��ͼ��');