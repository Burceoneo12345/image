clear;
mov=VideoReader('ʵ��4_���е�·��Ƶ.mp4');  %��ȡ��Ƶ����
imgRgb=read(mov,1);                         %��ȡһ֡��Ƶ
imgRgb1=im2double(imgRgb);                  %ͼ������ת��Ϊ˫����
R1=imgRgb1(:,:,1);                          %��ʼ��Rͨ������ֵ
G1=imgRgb1(:,:,2);                          %��ʼ��Gͨ������ֵ
B1=imgRgb1(:,:,3);                          %��ʼ��Bͨ������ֵ
q=1;
for t=2:20:mov.NumberOfFrames               %2��֡��������ÿ����20����
    imgRgb=read(mov,t);                     %��ȡ��Ӧ֡��Ƶ
    subplot(121);
    imshow(imgRgb);                         %��ʾÿһ֡
 
    imgRgb1=im2double(imgRgb);              %ͼ������ת��Ϊ˫����
    R=imgRgb1(:,:,1);                       %��ȡ��ǰ֡ͼ��Rͨ������ֵ
    G=imgRgb1(:,:,2);                       %��ȡ��ǰ֡ͼ��Gͨ������ֵ    
    B=imgRgb1(:,:,3);                       %��ȡ��ǰ֡ͼ��Bͨ������ֵ
    R1=R+R1;                                %����ǰ֡ͼ��Gͨ������ֵ����ǰ����֡ͼ��Rͨ������ֵ�ۼ�
    G1=G+G1;                                %����ǰ֡ͼ��Gͨ������ֵ����ǰ����֡ͼ��Gͨ������ֵ�ۼ�
    B1=B+B1;                                %����ǰ֡ͼ��Gͨ������ֵ����ǰ����֡ͼ��Bͨ������ֵ�ۼ�                    
    q=q+1;                                  %��ȡͼ��֡���ۼ�
    R2=R1*1/q;                              %��ȡ��ȡ������֡ͼ��Rͨ�����ؾ�ֵ            
    G2=G1*1/q;                              %��ȡ��ȡ������֡ͼ��Gͨ�����ؾ�ֵ
    B2=B1*1/q;                              %��ȡ��ȡ������֡ͼ��Bͨ�����ؾ�ֵ
    background=cat(3,R2,G2,B2);             %����ͨ�����ؾ�ֵ�ϲ�
    subplot(122);title('back');
    imshow(background,[]);                  %��ʾ֡ͼ��ĺϳɱ���
    drawnow;                                %ˢ����Ļ
end
 
imwrite(background,'back.jpg','jpg'); %����֡
