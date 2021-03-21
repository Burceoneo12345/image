clear;
mov=VideoReader('实验4_城市道路视频.mp4');  %读取视频函数
imgRgb=read(mov,1);                         %读取一帧视频
imgRgb1=im2double(imgRgb);                  %图像数据转化为双精度
R1=imgRgb1(:,:,1);                          %初始化R通道像素值
G1=imgRgb1(:,:,2);                          %初始化G通道像素值
B1=imgRgb1(:,:,3);                          %初始化B通道像素值
q=1;
for t=2:20:mov.NumberOfFrames               %2到帧的总数，每次以20增长
    imgRgb=read(mov,t);                     %读取相应帧视频
    subplot(121);
    imshow(imgRgb);                         %显示每一帧
 
    imgRgb1=im2double(imgRgb);              %图像数据转化为双精度
    R=imgRgb1(:,:,1);                       %获取当前帧图像R通道像素值
    G=imgRgb1(:,:,2);                       %获取当前帧图像G通道像素值    
    B=imgRgb1(:,:,3);                       %获取当前帧图像B通道像素值
    R1=R+R1;                                %将当前帧图像G通道像素值与先前所有帧图像R通道像素值累加
    G1=G+G1;                                %将当前帧图像G通道像素值与先前所有帧图像G通道像素值累加
    B1=B+B1;                                %将当前帧图像G通道像素值与先前所有帧图像B通道像素值累加                    
    q=q+1;                                  %读取图像帧数累加
    R2=R1*1/q;                              %获取读取的所有帧图像R通道像素均值            
    G2=G1*1/q;                              %获取读取的所有帧图像G通道像素均值
    B2=B1*1/q;                              %获取读取的所有帧图像B通道像素均值
    background=cat(3,R2,G2,B2);             %将三通道像素均值合并
    subplot(122);title('back');
    imshow(background,[]);                  %显示帧图像的合成背景
    drawnow;                                %刷新屏幕
end
 
imwrite(background,'back.jpg','jpg'); %保存帧
