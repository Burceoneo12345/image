clear;
mov=VideoReader('����ʵ��6�ز�.mp4');%��ȡ��Ƶ����
imgRgb=readframe(mov,1);%��ȡһ֡��Ƶ
imgRgb1=im2double(imgRgb);%ͼ������ת��Ϊ˫����
R1=imgRgb1(:,:,1);
G1=imgRgb1(:,:,2);
B1=imgRgb1(:,:,3);
q=1;
for t=2:20:mov.NumberOfFrames%2��֡��������ÿ����20����
    imgRgb=read(mov,t);%��ȡÿһ֡��Ƶ
    subplot(121);
    imshow(imgRgb);%��ʾÿһ֡
%     drawnow;%ˢ����Ļ
    imgRgb1=im2double(imgRgb);
    R=imgRgb1(:,:,1);
    G=imgRgb1(:,:,2);
    B=imgRgb1(:,:,3);
    R1=R+R1;
    G1=G+G1;
    B1=B+B1;
    q=q+1;
    R2=R1*1/q;
    G2=G1*1/q;
    B2=B1*1/q;%ÿһ�ζ�ȡ�ľ�ֵ
    background=cat(3,R2,G2,B2);%������ϲ�
    subplot(122);title('back');
    imshow(background,[]);%��ʾ����
    drawnow;%ˢ����Ļ
end

imwrite(background,'back.jpg','jpg');%����֡