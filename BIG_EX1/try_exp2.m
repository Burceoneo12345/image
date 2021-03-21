clear;
%% 读入图像
%img=imread('1.jpg');
[fileName,pathName] = uigetfile('*.*','Please select an image');%文件筐，选择文件
if(fileName)
    fileName = strcat(pathName,fileName);
    fileName = lower(fileName);%一致的小写字母形式
else 
    msgbox('Please select an image');
    return; %退出程序 
end
img=imread(fileName);
%% 创建图像副本，灰度化
i_copy=img;
i_copy=rgb2gray(i_copy);


subplot(2,2,1),imshow(i_copy),title('脑图');

%% 区域生长
f =double(i_copy);

%生长点选择
if( exist('x','var') == 0 && exist('y','var') == 0)

   hold on;
    [seedx,seedy] = getpts;%鼠标取点  回车确定
    seedx = round(seedx(1));%选择种子点
    seedy = round(seedy(1));
end


point=[seedy;seedx];
thresh=20;
maskim=zeros(size(f));
g=abs(f-f(seedy(1),seedx(1)))<=thresh;
maskim=maskim|g;

%定义全局变量
global moban
moban =zeros(size(f))+3;

%区域生长
quyu_grow(maskim,point);


%显示分割区域
[M,N]=size(moban);
for i=1:M
    for j=1:N
        if moban(i,j)==3
            moban(i,j)=0;
        end
    end
end
subplot(2,2,2),imshow(moban),title('区域(边界较为锯齿)');

%% 平滑操作
se1=strel('disk',20);
i_copy=imdilate(moban,se1);
i_copy=imerode(i_copy,se1);
subplot(2,2,3),imshow(i_copy),title('膨胀后腐蚀(平滑操作)');

%% 用Sobel算子进行边缘检测后通过膨胀扩大边沿
i_copy=edge(i_copy,'roberts'); 
se1=strel('disk',5);
i_copy=imdilate(i_copy,se1);
subplot(2,2,4),imshow(i_copy),title('边缘操作');

%% 将边沿绘制在原图像上，标红
for i=1:M
    for j=1:N
        if(i_copy(i,j)~=0)
            img(i,j,1)=255;
            img(i,j,2)=0;
            img(i,j,3)=0;
        end
    end
end
subplot(2,2,3),imshow(img),title('最终结果');



