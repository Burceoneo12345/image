function [new_img] = f_sobel_edge(old_img,T)
% sobel±ßÔµ¼ì²â£¬old_imgÎªÔ­Í¼Ïñ£¬new_imgÎªĞÂÍ¼Ïñ,TÎªãĞÖµ
    [row,col] = size(old_img);
    new_img = uint8(zeros(row,col));
    old_img = double(old_img);
    for i=2:row-1
        for j=2:col-1
            Gx = old_img(i+1,j-1)+2*old_img(i+1,j)+old_img(i+1,j+1)-(old_img(i-1,j-1)+2*old_img(i-1,j)+old_img(i-1,j+1));
            Gy = old_img(i-1,j+1)+2*old_img(i,j+1)+old_img(i+1,j+1)-(old_img(i-1,j-1)+2*old_img(i,j-1)+old_img(i+1,j-1));
            if uint8(sqrt(Gx^2+Gy^2)) >= T
                new_img(i,j) = 255;
            end
        end
    end
end