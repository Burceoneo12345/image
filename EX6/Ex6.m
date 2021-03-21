clc;clearvars;
% 读取视频信息
fileName = '课内实验6素材.mp4';
obj = VideoReader(fileName);
vidFrames = read(obj);% 读取所有的帧数据
numFrames = obj.numberOfFrames;%读取帧数
origin=cell(1,numFrames);
for k=1:numFrames
    origin{k} = vidFrames(:,:,:,k);
end
%% 背景差值法会运动目标的检测
old = origin{1};
back = origin{10};
% 假定背景静止不变
bid = background(old,back,0.2);
subplot(221),imshow(origin{1});title('原图第1张');
subplot(222),imshow(origin{10});title('原图第10张');
subplot(223),imshow(bid,[0,1]);title('背景差分');
%% 背景更新
back_tmp=im2double(origin{1});
R1=0;
G1=0;
B1=0;
q=0;
gausFilter = fspecial('gaussian',[5 5],1);
se = strel('square',5);  %创建10*10的正方形
for i=2:numFrames
    imgRgb1=im2double(origin{i-1});
    newFrame=im2double(origin{i});
    subplot(221),imshow(newFrame);title(['原始图像(当前帧为' num2str(i) ')']);
    R=imgRgb1(:,:,1);
    G=imgRgb1(:,:,2);
    B=imgRgb1(:,:,3);
    R1=R+R1;
    G1=G+G1;
    B1=B+B1;
    q=q+1;
    R2=R1/q;
    G2=G1/q;
    B2=B1/q;%每一次都取的均值
    back_rgb=cat(3,R2,G2,B2);%将矩阵合并
    
    subplot(222),imshow(back_rgb);title('背景图像');
    [bid,bid_tmp] = background(back_rgb,newFrame,0.2);
    subplot(223),imshow(bid_tmp);title('背景差分结果1');
    bid=imdilate(bid,se); %膨胀
    bid=imerode(bid,se); %腐蚀
    
    %消除优酷图标
    bid(1:50,440:512)=0;
    bid(1:50,1:100)=0;
    bid=bwareaopen(bid,10); %去掉部分噪点
    subplot(224),imshow(bid,[0,1]);title('背景差分结果2');
    pause(0.0005);
end