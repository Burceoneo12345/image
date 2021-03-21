clear;
obj = VideoReader('ʵ��4_���е�·��Ƶ.mp4');        %��ȡ��Ƶ����
vidFrames = read(obj);                              %��ȡ���е�֡����
numFrames = obj.numberOfFrames;                     %��ȡ��֡��
backFrame = imread('back.jpg');               %��ȡ����ͼ��
[m,n]=size(backFrame);                              %��ȡ����ͼ��ߴ��С
count=0;                                            %��ʼ����ͬ������Ӧ�ĳ�����Ŀ������
count1=0;
count2=0;
count3=0;
count4=0;
flag1=0;                                            %��ʼ����ͬ������Ӧ�ĳ���������־
flag2=0;
flag3=0;
flag4=0;
gausFilter = fspecial('gaussian',[5 5],1);                              %���ɸ�˹�˲���
se = strel('square',10);                                                %����10*10��������
for k=1:numFrames
    currentFrame=vidFrames(:,:,:,k);                                    %��ȡÿһ֡ͼ��
    newFrame=uint8(abs(double(currentFrame)-double(backFrame)));        %������ֵ���ָ�ͼ��
    newFrame=rgb2gray(newFrame);                                        %ͼ������ת��Ϊ˫����
    newFrame=imfilter(newFrame,gausFilter,'replicate');                 %���Կռ��˲�
    newFrame=im2bw(newFrame,0.1);                                       %��ֵ��
    newFrame=imdilate(newFrame,se);                                     %����
    newFrame=imerode(newFrame,se);                                      %��ʴ
    
    k1=newFrame(278:288,60:210);                                        %��������ѡ��
    k2=newFrame(278:288,211:380);
    k3=newFrame(278:288,450:512);
    k4=newFrame(150:160,430:512);
    
    imshow(currentFrame);
    hold on;
    rectangle('Position',[60,278,150,10],'EdgeColor','g');              %�������Ŀ�
    rectangle('Position',[211,278,170,10],'EdgeColor','g');
    rectangle('Position',[450,278,62,10],'EdgeColor','g');
    rectangle('Position',[430,160,82,10],'EdgeColor','g');
    
    newFrame=bwareaopen(newFrame,500);                                  %ȥ�������С����
    img_reg = regionprops(newFrame,  'area', 'boundingbox');            %���������ͨ��
    areas = [img_reg.Area];                                             %��ȡ��ͨ�����
    rects = cat(1,img_reg.BoundingBox);                                 %��ȡ��ͨ��߽�
    
    for i = 1:size(rects, 1)                                            %���������ͨ��
        rectangle('position', rects(i, :), 'EdgeColor', 'r');
    end
    n1=find(k1==1);                                                     %����������ж�Ϊ0�ĵ�ĸ���
    n2=find(k2==1);
    n3=find(k3==1);
    n4=find(k4==1);
    m1=length(n1);
    m2=length(n2);
    m3=length(n3);
    m4=length(n4);
    if(m1>500)                                                          %�ﵽ��ֵ����Ӧ��־����λ
        flag1=1;
    end
    if(m2>500)
        flag2=1;
    end
    if(m3>500)
        flag3=1;
    end
    if(m4>500)
        flag4=1;
    end
    if(m1<200&&flag1==1); count1=count1+1;flag1=0;rectangle('Position',[60,278,150,10],'EdgeColor','r'); end    %�������ӣ���־λ���㣬��������ɫ
    if(m2<200&&flag2==1); count2=count2+1;flag2=0;rectangle('Position',[211,278,170,10],'EdgeColor','r');end
    if(m3<300&&flag3==1); count3=count3+1;flag3=0;rectangle('Position',[450,278,62,10],'EdgeColor','r'); end
    if(m4<200&&flag4==1); count4=count4+1;flag4=0;rectangle('Position',[430,160,82,10],'EdgeColor','r'); end
    
    count=count1+count2+count3+count4;
    str4 = strcat('��һ����',num2str(count1),'   �ڶ�����',num2str(count2),'   ��������',num2str(count3),'   ���ĳ���',num2str(count4),'   ����:',num2str(count));
    title(str4);
    pause(0.01);
    hold off
end
