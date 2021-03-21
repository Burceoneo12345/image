function [new_img] = watershed_test(old_img)
f = double(old_img);
hv = fspecial('prewitt');
hh = hv';%�����ݶ�ͼ
gv=abs(imfilter(f,hv,'replicate'));
gh=abs(imfilter(f,hh,'replicate'));
g=sqrt(gv.^2+gh.^2);%�������
L=watershed(g);
wr=L==0;%��ˮ����
f(wr)=255;
new_img=uint8(f);
