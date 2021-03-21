function [new_img] = watershed_test(old_img)
f = double(old_img);
hv = fspecial('prewitt');
hh = hv';%计算梯度图
gv=abs(imfilter(f,hv,'replicate'));
gh=abs(imfilter(f,hh,'replicate'));
g=sqrt(gv.^2+gh.^2);%计算距离
L=watershed(g);
wr=L==0;%分水岭标记
f(wr)=255;
new_img=uint8(f);
