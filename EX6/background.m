function [bid,bid_tmp] = background(old_img,bg_img,T)
%new_img为差值图像，old_img为原始图像，bg_img为背景图像，T为阈值
	do = im2double(old_img);
	db = im2double(bg_img);
	id = abs(do-db);% 插值图像
	id=rgb2gray(id);
	gausFilter = fspecial('gaussian',[5 5],1);
	bid_tmp=imfilter(id,gausFilter,'replicate'); %线性空间滤波，去噪
	bid=im2bw(bid_tmp,T);       %二值化
end
