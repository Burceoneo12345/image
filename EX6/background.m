function [bid,bid_tmp] = background(old_img,bg_img,T)
%new_imgΪ��ֵͼ��old_imgΪԭʼͼ��bg_imgΪ����ͼ��TΪ��ֵ
	do = im2double(old_img);
	db = im2double(bg_img);
	id = abs(do-db);% ��ֵͼ��
	id=rgb2gray(id);
	gausFilter = fspecial('gaussian',[5 5],1);
	bid_tmp=imfilter(id,gausFilter,'replicate'); %���Կռ��˲���ȥ��
	bid=im2bw(bid_tmp,T);       %��ֵ��
end
