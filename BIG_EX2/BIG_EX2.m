clc;
clear;
for i=1:50
    name=num2str(i);
    filename = strcat('ʵ��2_3_TableTennis\stennisball',name,'.bmp');
    image=imread(filename);%��ȡǰ50֡ͼ��
    I=im2bw(image,220/255);%��ͼ���Զ���ֵ��
    [m,n]=size(I);%��ȡͼ��Ĵ�С
    M=zeros(m,n);%M��������ѡȡƹ�����˶�����
    length=180;
    if i>=40
        length=190-i*2+30;
    end
    for k=74:155
        for j=1:length
            M(j,k)=1;
        end
    end
    I=I.*M;%ȥ�����Ӽ���߰�ɫ����ĸ���
    f=bwareaopen(I,30);%ȥ��ͼ�������С��30�ĵ㣨ȥ���ֶ�ʶ���Ӱ�죩   
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
            if L(ii,jj)>=1
                sum_x=sum_x+ii;
                sum_y=sum_y+jj;
                area=area+1;
            end
        end
    end
    
    %��������
    plot_x(1)=fix(sum_x/area);
    plot_y(1)=fix(sum_y/area);
    imshow(image);
    
    %������Ϊ1�ľ��λ�Բ
    if i>=40
        rectangle('Position',[plot_y(1)-8,plot_x(1)-8,24-8,24-8],'Curvature',[1,1],'linewidth',2),axis equal%Ȧ��ƹ��������
    else
        rectangle('Position',[plot_y(1)-12,plot_x(1)-12,24,24],'Curvature',[1,1],'linewidth',2),axis equal%Ȧ��ƹ��������
    end
    pause(0.05);%��������ͼƬ

end
