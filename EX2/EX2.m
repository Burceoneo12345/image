close all;
clc;
clear;
img = imread('image1.jpeg');

%% 图像平移
x0 = 10;
y0 = 10;
mov_rot = [1,0,x0;0,1,y0;0,0,1];%平移矩阵
[h,w,l]=size(img);
new_h = h + x0;
new_w = w + y0;
new_mov_img = ones(new_h,new_w,l);
for i = 1 : h
    for j = 1 : w
        r=[i,j,1];
        r=mov_rot*r';
        new_mov_img(r(1),r(2))=img(i,j);
    end
end
figure
subplot(1,2,1)
imshow(img);
title('原图');
subplot(1,2,2)
imshow(uint8(new_mov_img));
title('平移后的图');
imwrite(new_mov_img,'new_mov_img.png');
%% 图像缩放
sx=1.5;
sy=1.5;
scale_rot = [sx,0,0;0,sy,0;0,0,1];%平移矩阵
[h,w,l]=size(img);
new_h = round(h * sx);
new_w = round(w * sy);
new_scale_img = ones(new_h,new_w,l);
for i = 1 : h
    for j = 1 : w
        r=[i,j,1];
        r=scale_rot*r';
        new_scale_img(round(r(1)),round(r(2)))=img(i,j);
    end
end
figure()
imshow(img);
title('原图');
figure()
imshow(uint8(new_scale_img));
title('缩放后的图（无插补）');


imwrite(new_scale_img,'new_scale_img.png');

%% 图像缩放 缩小
sx=0.5;
sy=0.5;
scale_rot = [sx,0,0;0,sy,0;0,0,1];%平移矩阵
[h,w,l]=size(img);
new_h = round(h * sx);
new_w = round(w * sy);
new_scale_img = ones(new_h,new_w,l);
for i = 1 : h
    for j = 1 : w
        r=[i,j,1];
        r=scale_rot*r';
        new_scale_img(round(r(1)),round(r(2)))=img(i,j);
    end
end
figure()
imshow(img);
title('原图');
figure()
imshow(uint8(new_scale_img));
title('缩小0.5倍后的图');

imwrite(new_scale_img,'new_scale_img.png');
%% 水平镜像
hor_mirror_img = img;
for i = 1 : h
    hor_mirror_img(i,1:end)=hor_mirror_img(i,end:-1:1);
end
figure
imshow(hor_mirror_img)
title('水平镜像')
imwrite(hor_mirror_img,'hor_mirror_img.png');
%% 垂直镜像
ver_mirror_img = img;
for i = 1 : w
    ver_mirror_img(1:end,i)=ver_mirror_img(end:-1:1,i);
end
figure
imshow(ver_mirror_img)
title('垂直镜像')

%%
figure()
subplot(131)
imshow(img)
title('原图');
subplot(132)
imshow(ver_mirror_img);
title('垂直镜像');
subplot(133)
imshow(hor_mirror_img)
title('水平镜像');
%% 线性插补
sx=1.5;
sy=1.5;
scale_rot = [sx,0,0;0,sy,0;0,0,1];%平移矩阵
new_h = round(h * sx);
new_w = round(w * sy);
new_scale_img2 = ones(new_h,new_w,l);
for i = 1 : new_h
    for j = 1 : new_w
        r=[i,j,1];
        r=scale_rot\r';
        x=r(1);
        y=r(2);
        u = x - floor(x);
        v = y - floor(y); 
        if x < 1           
            x = 1;
        end
          if y < 1           
            y = 1;
          end
           if x >=h            
            x = h;
           end
          if y >=w           
            y = w;
          end
        new_scale_img2(i,j,:)= img(floor(x), floor(y)) * (1-u) * (1-v); 
        new_scale_img2(i,j,:) = new_scale_img2(i,j)+img(floor(x), ceil(y)) * (1-u) * v;
        new_scale_img2(i,j,:) = new_scale_img2(i,j)+img(ceil(x), floor(y)) * u * (1-v);
        new_scale_img2(i,j,:) = new_scale_img2(i,j)+img(ceil(x), ceil(y)) * u * v;
    end
end
figure()
imshow(uint8(new_scale_img2));
title('放大1.5倍后的图');

%%  旋转线性插补
theta = 30;
theta = theta*pi/180;
rotate_rot = [cos(theta), sin(theta), 0; -sin(theta), cos(theta), 0; 0, 0, 1];
rot_h = floor(w*sin(theta) + h*cos(theta)) + 1;
rot_w = floor(w*cos(theta) + h*sin(theta)) + 1;
cent1 = [h/2; w/2; 1];
cent2 = [rot_h/2; rot_w/2; 1];
new_rotate_img2 = ones(rot_h, rot_w,3)*256;
for i = 1:rot_h
        for j = 1:rot_w
            r = [i,j,1];
            pos = round(rotate_rot*(r'-cent2)+cent1);
            if pos(1)>=1 && pos(1)<=h && pos(2)>=1 && pos(2)<=w
                new_rotate_img2(i, j,:) = img(pos(1), pos(2),:);
            end
        end        
end
figure()
subplot(121)
imshow(img)
title('原图');
subplot(122)
imshow(uint8(new_rotate_img2));
title('旋转30°后的图（线性插补）');

%%  旋转双线性插补
new_rotate_img3 = ones(rot_h, rot_w,3)*256;
for i = 1:rot_h
        for j = 1:rot_w
            r = [i,j,1];
            pos = round(rotate_rot*(r'-cent2)+cent1);
            x = floor(pos(1));
            y = floor(pos(2));
            u = pos(1)-x; 
            v = pos(2)-y; 
             if(x <= h-1 && y <= w-1 && x >= 2 && y >= 2)
               new_rotate_img3(i, j,:)=(1-u)*(1-v)*img(x,y,:) + u*(1-v)*img(x+1,y,:) +...
                (1-u)*v*img(x,y+1,:) + u*v*img(x+1,y+1,:);
             end
        end        
end
figure()
subplot(121)
imshow(img)
title('原图');
subplot(122)
imshow(uint8(new_rotate_img3));
title('旋转30°后的图（双线性插补）');