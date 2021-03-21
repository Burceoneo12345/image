clear;
obj = VideoReader('实验4_城市道路视频.mp4');        %读取视频函数
vidFrames = read(obj);                              %读取所有的帧数据
numFrames = obj.numberOfFrames;                     %读取总帧数
backFrame = imread('back.jpg');               %读取背景图像
[m,n]=size(backFrame);                              %读取背景图像尺寸大小
count=0;                                            %初始化不同车道对应的车辆数目计数器
count1=0;
count2=0;
count3=0;
count4=0;
flag1=0;                                            %初始化不同车道对应的车辆计数标志
flag2=0;
flag3=0;
flag4=0;
gausFilter = fspecial('gaussian',[5 5],1);                              %生成高斯滤波器
se = strel('square',10);                                                %创建10*10的正方形
for k=1:numFrames
    currentFrame=vidFrames(:,:,:,k);                                    %读取每一帧图像
    newFrame=uint8(abs(double(currentFrame)-double(backFrame)));        %背景差值法分割图像
    newFrame=rgb2gray(newFrame);                                        %图像数据转化为双精度
    newFrame=imfilter(newFrame,gausFilter,'replicate');                 %线性空间滤波
    newFrame=im2bw(newFrame,0.1);                                       %二值化
    newFrame=imdilate(newFrame,se);                                     %膨胀
    newFrame=imerode(newFrame,se);                                      %腐蚀
    
    k1=newFrame(278:288,60:210);                                        %检测区域的选择
    k2=newFrame(278:288,211:380);
    k3=newFrame(278:288,450:512);
    k4=newFrame(150:160,430:512);
    
    imshow(currentFrame);
    hold on;
    rectangle('Position',[60,278,150,10],'EdgeColor','g');              %检测区域的框定
    rectangle('Position',[211,278,170,10],'EdgeColor','g');
    rectangle('Position',[450,278,62,10],'EdgeColor','g');
    rectangle('Position',[430,160,82,10],'EdgeColor','g');
    
    newFrame=bwareaopen(newFrame,500);                                  %去除面积较小区域
    img_reg = regionprops(newFrame,  'area', 'boundingbox');            %检测所有连通域
    areas = [img_reg.Area];                                             %获取连通域面积
    rects = cat(1,img_reg.BoundingBox);                                 %获取连通域边界
    
    for i = 1:size(rects, 1)                                            %标记所有连通域
        rectangle('position', rects(i, :), 'EdgeColor', 'r');
    end
    n1=find(k1==1);                                                     %检测区域内判定为0的点的个数
    n2=find(k2==1);
    n3=find(k3==1);
    n4=find(k4==1);
    m1=length(n1);
    m2=length(n2);
    m3=length(n3);
    m4=length(n4);
    if(m1>500)                                                          %达到阈值后相应标志符置位
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
    if(m1<200&&flag1==1); count1=count1+1;flag1=0;rectangle('Position',[60,278,150,10],'EdgeColor','r'); end    %车数增加，标志位置零，检测区域变色
    if(m2<200&&flag2==1); count2=count2+1;flag2=0;rectangle('Position',[211,278,170,10],'EdgeColor','r');end
    if(m3<300&&flag3==1); count3=count3+1;flag3=0;rectangle('Position',[450,278,62,10],'EdgeColor','r'); end
    if(m4<200&&flag4==1); count4=count4+1;flag4=0;rectangle('Position',[430,160,82,10],'EdgeColor','r'); end
    
    count=count1+count2+count3+count4;
    str4 = strcat('第一车道',num2str(count1),'   第二车道',num2str(count2),'   第三车道',num2str(count3),'   第四车道',num2str(count4),'   车数:',num2str(count));
    title(str4);
    pause(0.01);
    hold off
end
