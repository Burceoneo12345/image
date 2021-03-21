clear;
clc;
old_img=imread('1.jpg');
imshow(old_img);
% subplot(121);
% imshow(old_img);title('原始图像');
img=rgb2gray(old_img);
new_img=double(img);
 
%% 图像二值化代码
T=(min(new_img(:))+max(new_img(:)))/2;
done=false;
i=0;
while~done
    r1=find(new_img<=T);
    r2=find(new_img>T);
    Tnew=(mean(new_img(r1))+mean(new_img(r2)))/2;
    done=abs(Tnew-T)<1;
    T=Tnew;
    i=i+1;
end
new_img(r1)=0;
new_img(r2)=1;
 
img = new_img;
 
 
%% 图像分割代码
offsetr=[-1,0,1,0];
offsetc=[0,1,0,-1];
next_search_dir_table=[4,1,2,3];
next_dir_table=[2,3,4,1];
start=-1;
boundary=-2;
 
% 中心点坐标（800，1000）
point_y = 800;
point_x = 1000;
[rv,cv]=find((img(point_y-1:end-2,point_x:end)==0)&(img(point_y:end-1,point_x:end)>0));
rv=rv+point_y-1;
cv=cv+point_x;
 
startr=rv(1);
startc=cv(1);
img=im2double(img);
img(startr,startc)=start;
 
cur_p=[startr,startc];
init_departure_dir=-1;
done=0;
next_dir=2;
while ~done
    dir=next_dir;
    found_neighbour=0;
    for i=1:length(offsetr)
        offset=[offsetr(dir),offsetc(dir)];
        neighbour=cur_p+offset;
        if(img(neighbour(1),neighbour(2)))~=0
            if(img(cur_p(1),cur_p(2))==start) & (init_departure_dir==-1)
                init_departure_dir=dir;
            elseif (img(cur_p(1),cur_p(2))==start)&(init_departure_dir==dir)
                    done=1;
                    found_neighbour=1;
                    break;
            end
            next_dir=next_search_dir_table(dir);
            found_neighbour=1;
            if img(neighbour(1),neighbour(2))~=start
                img(neighbour(1),neighbour(2))=boundary;
            end
            cur_p=neighbour;
            break;
        end
        dir=next_dir_table(dir);
    end
end
bi=find(img==boundary);
img(:)=0;
img(bi)=1;
img(startr,startc)=1;
 

%%
color = 120;
 
for i=1:size(img,1)
    for j=1:size(img,2)
        if img(i,j) == 1
            old_img(i,j)=color;
            for m = 1:10
            old_img(i+m,j+m)=color;
            old_img(i-m,j-m)=color;
            old_img(i+m,j-m)=color;
            old_img(i-m,j+m)=color;
            end
        end
    end
end
figure;
imshow(old_img);title('边界');
