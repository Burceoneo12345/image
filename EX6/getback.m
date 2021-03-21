clear;
mov=VideoReader('课内实验6素材.mp4');%读取视频函数
imgRgb=readframe(mov,1);%读取一帧视频
imgRgb1=im2double(imgRgb);%图像数据转化为双精度
R1=imgRgb1(:,:,1);
G1=imgRgb1(:,:,2);
B1=imgRgb1(:,:,3);
q=1;
for t=2:20:mov.NumberOfFrames%2到帧的总数，每次以20增长
    imgRgb=read(mov,t);%读取每一帧视频
    subplot(121);
    imshow(imgRgb);%显示每一帧
%     drawnow;%刷新屏幕
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
    B2=B1*1/q;%每一次都取的均值
    background=cat(3,R2,G2,B2);%将矩阵合并
    subplot(122);title('back');
    imshow(background,[]);%显示背景
    drawnow;%刷新屏幕
end

imwrite(background,'back.jpg','jpg');%保存帧