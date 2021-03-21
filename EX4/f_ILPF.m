function [new_img] = f_ILPF(old_img,D0)
% 理想低通滤波，old_img为原始图像，new_img为新图像，D0为截止频率
[row, col] = size(old_img);
fp=double(old_img);
% 对图像进行傅里叶变换
F1 = fft2(fp);
G1 = fftshift(F1); % 数据矩阵平衡
% 生成理想低通滤波函数
n1=floor(row/2);
n2=floor(col/2);
H = zeros(row, col);
for u = 1 : row
    for v = 1 : col
        temp = sqrt((u-n1)^2 + (v-n2)^2);
        if temp <= D0
            H(u,v) = 1;
        else
            H(u,v) = 0;
        end
    end
end
%进行滤波
G = G1.*H;
G = ifftshift(G);%逆零频移
% 反傅里叶变换
gp = ifft2(G);
% 处理得到的图像
new_img = uint8(real(gp));

end