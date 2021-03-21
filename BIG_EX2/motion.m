clc;
u = rgb2gray(imread('./ʵ��2_3_TableTennis/stennisball0.bmp'));
background = zeros(size(u));
background = background + double(u);

alpha = 0.6;

for i = 1:34
    img = rgb2gray(imread(['./ʵ��2_3_TableTennis/stennisball', num2str(i), '.bmp']));
    background = background + double(img);
end
background = background / 35;
background = uint8(background);
imwrite(background, 'background.jpg');
% figure(1);imshow(background);

for i = 0:10
    img = imread(['./ʵ��2_3_TableTennis/stennisball', num2str(i), '.bmp']);
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
    se=strel('disk',2);%����һ���뾶Ϊ2��Բ�νṹԪ��
    I1=imdilate(f,se);%�ýṹԪ��se��ͼ������������
    [L,num]=bwlabel(I1,8);%��ע������ͼ���������ӵĲ���
    
    plot_x=zeros(1,1);%���ڼ�¼����λ�õ�����
    plot_y=zeros(1,1);
    %������
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
    
    %��������
    plot_x(1)=fix(sum_x/area);
    plot_y(1)=fix(sum_y/area);
    figure(2);imshow(img);
    %������Ϊ1�ľ��λ�Բ
    if i>=40
        rectangle('Position',[plot_y(1)-7,plot_x(1)-7,24-7,24-7],'Curvature',[1,1],'linewidth',1),axis equal%Ȧ��ƹ��������
    else
        rectangle('Position',[plot_y(1)-12,plot_x(1)-12,24,24],'Curvature',[1,1],'linewidth',1),axis equal%Ȧ��ƹ��������
    end
    
    pause(0.05);
end
