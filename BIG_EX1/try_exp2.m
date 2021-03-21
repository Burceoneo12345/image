clear;
%% ����ͼ��
%img=imread('1.jpg');
[fileName,pathName] = uigetfile('*.*','Please select an image');%�ļ���ѡ���ļ�
if(fileName)
    fileName = strcat(pathName,fileName);
    fileName = lower(fileName);%һ�µ�Сд��ĸ��ʽ
else 
    msgbox('Please select an image');
    return; %�˳����� 
end
img=imread(fileName);
%% ����ͼ�񸱱����ҶȻ�
i_copy=img;
i_copy=rgb2gray(i_copy);


subplot(2,2,1),imshow(i_copy),title('��ͼ');

%% ��������
f =double(i_copy);

%������ѡ��
if( exist('x','var') == 0 && exist('y','var') == 0)

   hold on;
    [seedx,seedy] = getpts;%���ȡ��  �س�ȷ��
    seedx = round(seedx(1));%ѡ�����ӵ�
    seedy = round(seedy(1));
end


point=[seedy;seedx];
thresh=20;
maskim=zeros(size(f));
g=abs(f-f(seedy(1),seedx(1)))<=thresh;
maskim=maskim|g;

%����ȫ�ֱ���
global moban
moban =zeros(size(f))+3;

%��������
quyu_grow(maskim,point);


%��ʾ�ָ�����
[M,N]=size(moban);
for i=1:M
    for j=1:N
        if moban(i,j)==3
            moban(i,j)=0;
        end
    end
end
subplot(2,2,2),imshow(moban),title('����(�߽��Ϊ���)');

%% ƽ������
se1=strel('disk',20);
i_copy=imdilate(moban,se1);
i_copy=imerode(i_copy,se1);
subplot(2,2,3),imshow(i_copy),title('���ͺ�ʴ(ƽ������)');

%% ��Sobel���ӽ��б�Ե����ͨ�������������
i_copy=edge(i_copy,'roberts'); 
se1=strel('disk',5);
i_copy=imdilate(i_copy,se1);
subplot(2,2,4),imshow(i_copy),title('��Ե����');

%% �����ػ�����ԭͼ���ϣ����
for i=1:M
    for j=1:N
        if(i_copy(i,j)~=0)
            img(i,j,1)=255;
            img(i,j,2)=0;
            img(i,j,3)=0;
        end
    end
end
subplot(2,2,3),imshow(img),title('���ս��');



