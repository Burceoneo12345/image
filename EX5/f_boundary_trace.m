function new_img = f_boundary_trace(old_img,point_y,point_x)
offsetr=[-1,0,1,0];
offsetc=[0,1,0,-1];
next_search_dir_table=[4,1,2,3];
next_dir_table=[2,3,4,1];
start=-1;
boundary=-2;


[rv,cv]=find((old_img(point_y-1:end-2,point_x:end)==0)&(old_img(point_y:end-1,point_x:end)>0));%找出起始点
rv=rv+point_y-1;
cv=cv+point_x;

startr=rv(1);%起始点
startc=cv(1);
old_img=im2double(old_img);
old_img(startr,startc)=start;


cur_p=[startr,startc];
init_departure_dir=-1;
done=0;%完成标志
next_dir=2;%初始搜寻方向
while ~done
    dir=next_dir;
    found_neighbour=0;
    for i=1:length(offsetr)
        offset=[offsetr(dir),offsetc(dir)];
        neighbour=cur_p+offset;
        if(old_img(neighbour(1),neighbour(2)))~=0%找到新的边缘点
            if(old_img(cur_p(1),cur_p(2))==start) && (init_departure_dir==-1)
                init_departure_dir=dir;%记下离开起始点的方向 
            elseif (old_img(cur_p(1),cur_p(2))==start)&&(init_departure_dir==dir)
                done=1;
                found_neighbour=1;%找到下一个边界点
                break;
            end
            next_dir=next_search_dir_table(dir);
            found_neighbour=1;
            if old_img(neighbour(1),neighbour(2))~=start
                old_img(neighbour(1),neighbour(2))=boundary;
            end
            cur_p=neighbour;
            break;
        end
        
        dir=next_dir_table(dir);
    end
    % =====
    if found_neighbour == 0
        break;
    end
    % =====
end
bi=old_img==boundary;
old_img(:)=0;
old_img(bi)=1;
old_img(startr,startc)=1;
new_img = imbinarize(old_img);
end