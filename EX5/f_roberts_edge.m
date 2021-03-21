function [new_img] = f_roberts_edge(old_img,T)
% old_img为原始图像，T为阈值，new_img为输出图像
    [row,col] = size(old_img);
    new_img = uint8(zeros(row,col));
    old_img = double(old_img);
    for i=1:row-1
        for j=1:col-1
            Gx = old_img(i+1,j+1)-old_img(i,j);
            Gy = old_img(i,j+1)-old_img(i+1,j);
            if uint8(sqrt(Gx^2+Gy^2)) >= T
                new_img(i,j) = 255;
            end
        end
    end
end