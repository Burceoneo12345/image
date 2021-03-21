function [new_img] = f_sobel(old_img)
% sobel±ßÔµ¼ì²â£¬old_imgÎªÔ­Í¼Ïñ£¬new_imgÎªÐÂÍ¼Ïñ
    [h,w] = size(old_img);
    new_img = zeros(h,w);
    old_img = double(old_img);
    rot_x = [1,2,1;0,0,0;-1,-2,-1];
    rot_y = [1,0,-1;2,0,-2;1,0,-1];
    for i=2:h-1
        for j=2:w-1
            G = [old_img(i-1:i+1,j-1),old_img(i-1:i+1,j),old_img(i-1:i+1,j+1)];
            Gx = sum(sum(G.*rot_x));
            Gy = sum(sum(G.*rot_y));
            new_img(i,j) = sqrt(Gx^2+Gy^2);
        end
    end
    new_img = uint8(new_img);
end