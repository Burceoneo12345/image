clc;clearvars;
% ��ȡ��Ƶ��Ϣ
fileName = '����ʵ��6�ز�.mp4';
obj = VideoReader(fileName);
vidFrames = read(obj);% ��ȡ���е�֡����
numFrames = obj.numberOfFrames;%��ȡ֡��
origin=cell(1,numFrames);
for k=1:numFrames
    origin{k} = vidFrames(:,:,:,k);
end
%% ������ֵ�����˶�Ŀ��ļ��
old = origin{1};
back = origin{10};
% �ٶ�������ֹ����
bid = background(old,back,0.2);
subplot(221),imshow(origin{1});title('ԭͼ��1��');
subplot(222),imshow(origin{10});title('ԭͼ��10��');
subplot(223),imshow(bid,[0,1]);title('�������');
%% ��������
back_tmp=im2double(origin{1});
R1=0;
G1=0;
B1=0;
q=0;
gausFilter = fspecial('gaussian',[5 5],1);
se = strel('square',5);  %����10*10��������
for i=2:numFrames
    imgRgb1=im2double(origin{i-1});
    newFrame=im2double(origin{i});
    subplot(221),imshow(newFrame);title(['ԭʼͼ��(��ǰ֡Ϊ' num2str(i) ')']);
    R=imgRgb1(:,:,1);
    G=imgRgb1(:,:,2);
    B=imgRgb1(:,:,3);
    R1=R+R1;
    G1=G+G1;
    B1=B+B1;
    q=q+1;
    R2=R1/q;
    G2=G1/q;
    B2=B1/q;%ÿһ�ζ�ȡ�ľ�ֵ
    back_rgb=cat(3,R2,G2,B2);%������ϲ�
    
    subplot(222),imshow(back_rgb);title('����ͼ��');
    [bid,bid_tmp] = background(back_rgb,newFrame,0.2);
    subplot(223),imshow(bid_tmp);title('������ֽ��1');
    bid=imdilate(bid,se); %����
    bid=imerode(bid,se); %��ʴ
    
    %�����ſ�ͼ��
    bid(1:50,440:512)=0;
    bid(1:50,1:100)=0;
    bid=bwareaopen(bid,10); %ȥ���������
    subplot(224),imshow(bid,[0,1]);title('������ֽ��2');
    pause(0.0005);
end