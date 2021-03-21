function [new_img] = f_Median(old_img)
[h,w] = size(old_img);
new_img = zeros(h,w);
for i = 2 : h-1
    for j = 2 : w-1
        m = [old_img(i-1:i+1,j-1);old_img(i-1:i+1,j);old_img(i-1:i+1,j+1)];
        new_img(i,j)=median(m);
    end
end
new_img = uint8(new_img);
end