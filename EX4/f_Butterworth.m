function [new_img] = f_Butterworth(old_img,D0,N)
% ��������ַ��˲���old_imgΪԭʼͼ��new_imgΪ��ͼ��D0Ϊ��ֹƵ�ʣ�NΪ����
[row, col] = size(old_img);
fp=double(old_img);
% ��ͼ����и���Ҷ�任
F1 = fft2(fp);
G1 = fftshift(F1); % ���ݾ���ƽ��
% ���ɰ�����˹��ͨ�˲�����
n1=floor(row/2);
n2=floor(col/2);
H = zeros(row, col);
for u = 1 : row
    for v = 1 : col
        temp = sqrt((u-n1)^2 + (v-n2)^2);
        if temp==0
            H(u, v) = 0;
        else
            H(u, v) = 1 / (1 + (D0/temp)^(2 * N))+0;
        end
    end
end
%�����˲�
G = G1.*H;
G = ifftshift(G);%����Ƶ��
% ������Ҷ�任
gp = ifft2(G);
% ����õ���ͼ��
new_img = uint8(real(gp));

end


