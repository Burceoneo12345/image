clear;
fileName = '课内实验6素材.mp4';
obj = VideoReader(fileName);
vidFrames = read(obj);% 读取所有的帧数据
numFrames = obj.numberOfFrames;%读取帧数
backFrame = imread('back.jpg');
[m,n]=size(backFrame);
count=0;
count1=0;
count2=0;
count3=0;
flag1=0;
flag2=0;
flag3=0;
figure;

se = strel('square',5);  %创建10*10的正方形
% se1 = strel('square',5);  %创建5*5的正方形
for k=1:numFrames
    currentFrame=vidFrames(:,:,:,k);
    newFrame=uint8(abs(double(currentFrame)-double(backFrame))); %背景差值法分割图像
    subplot(221),imshow(newFrame);
    newFrame=rgb2gray(newFrame);
    newFrame=imfilter(newFrame,gausFilter,'replicate'); %线性空间滤波
    newFrame=im2bw(newFrame,0.1);       %二值化
    newFrame=imdilate(newFrame,se);     %膨胀
    newFrame=imerode(newFrame,se);
    % 去掉两个路边背景
    newFrame(1:50,440:512)=0;
    newFrame(1:50,1:100)=0;
    subplot(222),imshow(newFrame);
    % newFrame=imerode(newFrame,se1);
    k1=newFrame(278:288,50:200);
    k2=newFrame(278:288,210:380);
    k3=newFrame(278:288,380:512);
    
    %     imshow(currentFrame);
    
    %     image=bwlabel(newFrame,4);
    %     image1=regionprops(image,'all');
    %     imshow(image); hold on
    %     for i = 1 : size(image1, 1)
    %         boundary = image1(i).BoundingBox;
    %         rectangle('Position',boundary,'edgecolor','r' );
    %     end
    newFrame=bwareaopen(newFrame,400);
    
    img_reg = regionprops(newFrame,  'area', 'boundingbox');
    areas = [img_reg.Area];
    rects = cat(1, img_reg.BoundingBox);
    
    subplot(223),imshow(currentFrame);
    hold on
    for i = 1:size(rects, 1)
        rectangle('position', rects(i, :), 'EdgeColor', 'b');
    end
    
    
    rectangle('Position',[50,278,150,10],'EdgeColor','g');
    rectangle('Position',[210,278,170,10],'EdgeColor','g');
    rectangle('Position',[380,278,132,10],'EdgeColor','g');
    
    n1=find(k1==1);
    n2=find(k2==1);
    n3=find(k3==1);
    m1=length(n1);
    m2=length(n2);
    m3=length(n3);
    if(m1>500)
        flag1=1;
    end
    if(m2>500)
        flag2=1;
    end
    if(m3>500)
        flag3=1;
    end
    if(m1<200&&flag1==1); count1=count1+1;flag1=0;rectangle('Position',[50,278,150,10],'EdgeColor','r'); end
    if(m2<200&&flag2==1); count2=count2+1;flag2=0;rectangle('Position',[210,278,170,10],'EdgeColor','r');end
    if(m3<300&&flag3==1); count3=count3+1;flag3=0;rectangle('Position',[380,278,132,10],'EdgeColor','r'); end
    count=count1+count2+count3;
    str4 = strcat('第二车道',num2str(count1),'   第三车道',num2str(count2),'   第四车道',num2str(count3),'   车数:',num2str(count));
    title(str4);
    pause(0.001);
    hold off
end
