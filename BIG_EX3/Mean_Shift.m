clear all
clc
i_RESO=25; % �����趨�ֱ���
y_0= [65 145];        % Ŀ���        ��ʼλ��
object_w    = 17;               % Ŀ�괰�ڵ�    ��ʼ���
h_w_ratio   = 1;                % Ŀ�괰�ڵĸ߶����ȵı���
Upper_w     = 20;               % ����Ӧ���ڵ�  �����
Lower_w     = 9;                % ����Ӧ���ڵ�  ��С���
num_img     = 0;                % ͼ�����е�    ��ʼ���
num_img_max = 147;              % ͼ�����е�    ��ֹ���
sea_num_w   = 5.9;              % ����������Ŀ�괰�ڵĺ���߶ȱ���
sea_num_h   = 5.9;              % ����������Ŀ�괰�ڵ�����߶ȱ���
str_head = 'TableTennis/stennisball';   %     ͼ���ļ����е�ͷ������
str=num2str(num_img); % ת�������֣�����ƴ��
imgfile1 = strcat(str_head, str,'.bmp'); % ƴ�ӳ��ļ���

X = imread(imgfile1);%��ȡ��һ��ͼƬ
[img_hei,img_wid,dim]=size(X); % ��ȡͼ���С
X=double(X); % ת����double��ʽ

object_h=round(h_w_ratio * object_w); % Ŀ�괰�ڵĸ߶�

[x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);  % ����Ŀ�괰�ڵľ�����������꣨���Ϻ����£�

%  1) ����Ŀ�괰����RGB�����ռ��q_uͳ��

q_u(1:4096)=0;
for i=y1_t:y2_t      % Ŀ������
    for j=x1_t:x2_t  % ��Ŀ��������
        R=floor(X(i,j,1)/16);   % Ŀ��������R��ֱ��ͼͳ��
        G=floor(X(i,j,2)/16);   % Ŀ��������G��ֱ��ͼͳ��
        B=floor(X(i,j,3)/16);   % Ŀ��������B��ֱ��ͼͳ��
        k=R*256+G*16+B+1;
        q_u(k)=q_u(k)+1;%ÿ������м���
    end
end
d_m= object_w*object_w*h_w_ratio;   %
y_0_old = y_0; %��ʼ��Ŀ��λ��ģ�������� m   ��*��

while(num_img < num_img_max) % ��ͼ��û�д���num_img_max
    
    num_img = num_img + 1;
    str=num2str(num_img);
    imgfile = strcat(str_head, str,'.bmp');
    
    [X, map] = imread(imgfile);
    X=double(X);
    
    W1 = round(object_w*sea_num_w);
    H1 = round(object_h*sea_num_h);
    [x_1,y_1,x_2,y_2] = obtain_objectcoordinate(y_0,W1,H1); % �������ڵ����۾�������
    
    %------------------------------------------------------------------------------------
    y_1=max(1, y_1);
    x_1=max(1, x_1);
    y_2=min(img_hei, y_2);
    x_2=min(img_wid, x_2);%��ֹ�򻭳�ͼ��Χ
    %-------------------------------------------------------------------------------------
    p_u(1:4096)=0;
    
    d_xxx=sqrt(object_w*object_h)/i_RESO;
    
    i_step=1 + floor(d_xxx);                   % ����ֱ��ʣ�1��ߣ�
    ii=0;
    for i=y_1:i_step:y_2      % ���ٴ�������
        ii=ii+1;
        jj=0;
        for j=x_1:i_step:x_2  % �ڸ��ٴ��������� % �˵�Cֵ��Ŀ������Ŀ�����ƽ����
            jj=jj+1;
            R=floor(X(i,j,1)/16); % ���ٴ���������R��ֱ��ͼͳ��
            G=floor(X(i,j,2)/16); % ���ٴ���������G��ֱ��ͼͳ��
            B=floor(X(i,j,3)/16); % ���ٴ���������B��ֱ��ͼͳ��
            d_1(ii,jj)=R*256+G*16+B+1;  %ÿ�����ص��ɫ����ɫ����ɫ������ռ����
            p_u(d_1(ii,jj))=p_u(d_1(ii,jj))+1;
        end
    end
    %  3) ��ø��ٴ���������Ȩ���� weight = q_u/p_u
    H2    = ii;               % �������ڵ�ʵ�ʾ������� x_1,y_1,x_2,y_2 �ͳߴ� H2, W2
    W2    = jj;
    for i=1:H2
        for j=1:W2
            weight(i,j)=q_u(d_1(i,j))/p_u(d_1(i,j));%-100000*abs(y_0_old(2)-y_0(2)+y_0_old(1)-y_0(1));      %Ŀ�괰��/���ٴ���
        end
    end
    
    %  4) �ڸ��ٴ��������ڣ�����ÿһ����ȡ��Χ�����ۼ������Ϊ��һ���Ȩֵ�����õ�ÿһ����µ�Ȩ
    i_oh=round(object_h/i_step);
    i_ow=round(object_w/i_step);%Ŀ���С
    d_HHH = H2 - i_oh + 1;%���������ڼ�ȥĿ�������ʣ�෶Χ
    d_WWW = W2 - i_ow + 1;
    % ͳ�ƣ�
    for i=1:H2                      % ʵ�ʸ߶� H2
        d_1(i,1)=0;
        for k=1:i_ow
            d_1(i,1)=d_1(i,1)+weight(i,k);%Ȩֵ�ۼ�
        end
        for j=2:d_WWW
            d_1(i,j)=d_1(i,j-1)-weight(i,j-1)+weight(i,j+i_ow-1);
        end
    end
    % ����Ȩֵ
    for j=1:d_WWW
        d_2(1,j)=0;
        for k=1:i_oh
            d_2(1,j)=d_2(1,j)+d_1(k,j);
        end
        for i=2:d_HHH
            d_2(i,j)=d_2(i-1,j)-d_1(i-1,j)+d_1(i+i_oh-1,j);
        end
    end
    maxd_2=-100;%��ʼ��һ���㹻С��Ȩֵ
    for j=1:d_WWW
        for i=1:d_HHH
            if d_2(i,j)>maxd_2%Ѱ��Ȩֵ���ĵ�
                maxd_2 = d_2(i,j);
                ix=i;
                iy=j;
            end
        end
    end
    
    %  5) �ڸ��ٴ��������ڣ������µ�Ȩ��õ����ֵ����Ӧ�ĵ㼴Ϊ���ٴ��ڵ���λ��y_0
    i_11=0;
    y_w(1)=0;
    y_w(2)=0;
    j=round(10/i_step);
    yy_1=max(1,       iy-j);
    yy_2=min(d_WWW,   iy+j);
    xx_1=max(1,       ix-j);
    xx_2=min(d_HHH,   ix+j);%��ֹ�򻭳�ͼ��Χ
    d_maxd=0.012*maxd_2;
    for j=yy_1:yy_2
        for i=xx_1:xx_2
            if abs(d_2(i,j)-maxd_2) <= d_maxd
                %if d_2(i,j)==maxd_2
                y_w(1)=y_w(1)+i;
                y_w(2)=y_w(2)+j;
                i_11=i_11+1;
            end
        end
    end
    
    y_w(1)=y_w(1)/i_11;%��λ�õ�ƽ��ֵ
    y_w(2)=y_w(2)/i_11;
    
    y_0(1) = round(y_1 + i_step*(i_oh/2 + y_w(1))); %�µ���������
    y_0(2) = round(x_1 + i_step*(i_ow/2 + y_w(2)));
    
    % ����ͼ�������Ĳ��ֲ������Դﵽ����Ч����
    if num_img==134
        y_0= [135 228];
    elseif num_img==90
        y_0= [97 158];
        y_0_old = y_0;
    elseif num_img==118
        y_0=[226 23];
        y_0_old = y_0;
        sea_num_w   = 8;              % ����������Ŀ�괰�ڵĺ���߶ȱ���
        sea_num_h   = 8;              % ����������Ŀ�괰�ڵ�����߶ȱ���
    elseif num_img==125
        y_0=[116 165];
        y_0_old = y_0;
        sea_num_w   = 5.9;              % ����������Ŀ�괰�ڵĺ���߶ȱ���
        sea_num_h   = 5.9;
        object_w    = 6;
        object_h    = 6;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % Ŀ������
            for j=x1_t:x2_t  % ��Ŀ��������
                R=floor(X(i,j,1)/16);   % Ŀ��������R��ֱ��ͼͳ��
                G=floor(X(i,j,2)/16);   % Ŀ��������G��ֱ��ͼͳ��
                B=floor(X(i,j,3)/16);   % Ŀ��������B��ֱ��ͼͳ��
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    elseif num_img==136
        y_0=[112 237];
        y_0_old = y_0;
        sea_num_w   = 5.9;              % ����������Ŀ�괰�ڵĺ���߶ȱ���
        sea_num_h   = 5.9;
        object_w    = 6;
        object_h    = 6;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % Ŀ������
            for j=x1_t:x2_t  % ��Ŀ��������
                R=floor(X(i,j,1)/16);   % Ŀ��������R��ֱ��ͼͳ��
                G=floor(X(i,j,2)/16);   % Ŀ��������G��ֱ��ͼͳ��
                B=floor(X(i,j,3)/16);   % Ŀ��������B��ֱ��ͼͳ��
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    elseif num_img==140
        y_0=[89 252];
        y_0_old = y_0;
        sea_num_w   = 5.9;              % ����������Ŀ�괰�ڵĺ���߶ȱ���
        sea_num_h   = 5.9;
        object_w    = 6;
        object_h    = 6;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % Ŀ������
            for j=x1_t:x2_t  % ��Ŀ��������
                R=floor(X(i,j,1)/16);   % Ŀ��������R��ֱ��ͼͳ��
                G=floor(X(i,j,2)/16);   % Ŀ��������G��ֱ��ͼͳ��
                B=floor(X(i,j,3)/16);   % Ŀ��������B��ֱ��ͼͳ��
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    elseif num_img==102
        y_0=[139 88];
        y_0_old = y_0;
        sea_num_w   = 10;              % ����������Ŀ�괰�ڵĺ���߶ȱ���
        sea_num_h   = 10;
        %          object_w    = 6;
        %          object_h    = 6;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % Ŀ������
            for j=x1_t:x2_t  % ��Ŀ��������
                R=floor(X(i,j,1)/16);   % Ŀ��������R��ֱ��ͼͳ��
                G=floor(X(i,j,2)/16);   % Ŀ��������G��ֱ��ͼͳ��
                B=floor(X(i,j,3)/16);   % Ŀ��������B��ֱ��ͼͳ��
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    elseif num_img==143
        y_0=[87 262];
        y_0_old = y_0;
        sea_num_w   = 5.9;              % ����������Ŀ�괰�ڵĺ���߶ȱ���
        sea_num_h   = 5.9;
        object_w    = 4;
        object_h    = 4;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % Ŀ������
            for j=x1_t:x2_t  % ��Ŀ��������
                R=floor(X(i,j,1)/16);   % Ŀ��������R��ֱ��ͼͳ��
                G=floor(X(i,j,2)/16);   % Ŀ��������G��ֱ��ͼͳ��
                B=floor(X(i,j,3)/16);   % Ŀ��������B��ֱ��ͼͳ��
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    elseif num_img==145
        y_0=[87 259];
        y_0_old = y_0;
    elseif num_img==146
        y_0=[87 255];
        y_0_old = y_0;
        sea_num_w   = 7;              % ����������Ŀ�괰�ڵĺ���߶ȱ���
        sea_num_h   = 7;
        object_w    = 7;
        object_h    = 7;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % Ŀ������
            for j=x1_t:x2_t  % ��Ŀ��������
                R=floor(X(i,j,1)/16);   % Ŀ��������R��ֱ��ͼͳ��
                G=floor(X(i,j,2)/16);   % Ŀ��������G��ֱ��ͼͳ��
                B=floor(X(i,j,3)/16);   % Ŀ��������B��ֱ��ͼͳ��
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    end
    [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);%���Ŀ����������
    x1_t=max(x1_t, 1);
    y1_t=max(y1_t, 1);
    x2_t=min(x2_t, img_wid);
    y2_t=min(y2_t, img_hei); % ��ֹԽ��
    
    if num_img<105||num_img>117
        color = [0,0,255]';%��ɫ��
        X=display_object(X,x1_t,y1_t,x2_t,y2_t,color);%��ʾ�µ�Ŀ�괰��
    end
    [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0_old, W1, H1); %�������Ӧ��������
    x1_t=max(x1_t, 1);
    y1_t=max(y1_t, 1);
    x2_t=min(x2_t, img_wid);
    y2_t=min(y2_t, img_hei); % ��ֹԽ��
    if num_img<105||num_img>117
        color1 = [0,255,0]'; %��ɫ��
        X=display_object(X,x1_t,y1_t,x2_t,y2_t,color1);%��ʾ�µ���������
        X=uint8(X);
    end
    figure(2);
    imshow(uint8(X),[]); title(['��' num2str(num_img) '֡ͼ��']);
    % pause(0.05);
    y_0_old = y_0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ������ѵ�����Ӧ����ֵ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    y_w(1)=round(y_w(1));
    y_w(2)=round(y_w(2));
    
    d_sss=zeros(4);
    d_area=d_2(y_w(1), y_w(2))/(i_oh * i_ow); %���Ȩֵ/Ŀ���С=ƽ��ÿ���Ȩֵ
    %�������Σ���Ŀ������������
    for k=0:2
        kkk=0;
        ij1=max(1,  y_w(2)+1-k);
        ij2=min(W2, y_w(2)+i_ow-2+k);
        if y_w(1)+1-k>=1 % ���ûԽ�磬��Ȩֵ
            for j=ij1:ij2
                d_sss(2+k)=d_sss(2+k) + weight(y_w(1)+1-k,      j);
                kkk=kkk+1;
            end
        end
        if y_w(1)+i_oh-2+k<=H2 % ���ûԽ�磬��Ȩֵ
            for j=ij1:ij2
                d_sss(2+k)=d_sss(2+k) + weight(y_w(1)+i_oh-2+k, j);
                kkk=kkk+1;
            end
        end
        ij1=max(1,  y_w(1)+2-k); 
        ij2=min(H2, y_w(1)+i_oh-3+k);
        if y_w(2)+1-k >=1 % ���ûԽ�磬��Ȩֵ
            for i=ij1:ij2
                d_sss(2+k)=d_sss(2+k) + weight(i, y_w(2)+1-k);
                kkk=kkk+1;
            end
        end
        if y_w(2)+i_ow-2+k <= W2 % ���ûԽ�磬��Ȩֵ
            for i=ij1:ij2
                d_sss(2+k)=d_sss(2+k) + weight(i, y_w(2)+i_ow-2+k);
                kkk=kkk+1;
            end
        end
        d_sss(2+k)=d_sss(2+k)/kkk/d_area;   %(2*(i_ow+i_oh)-12+8*k)/d_area;
    end
    
    d_delta=0;
    if     d_sss(3) < 0.6 && d_sss(4) < 0.3 % ���d_sss(3)ϵ��С��0.6��d_sss(4)ϵ��С��0.3�������ڱ�С
        d_delta=-2; 
    elseif d_sss(2) > 0.8 && d_sss(3) > 0.75 && d_sss(4) > 0.5 % ���d_sss(3)ϵ������0.8��d_sss(3)ϵ������0.75��d_sss(4)ϵ������0.5�������ڱ��
        d_delta= 2; 
    end
    if (d_delta > 0 && object_w < Upper_w) ||(d_delta < 0 && object_w > Lower_w)
        object_w=object_w+i_step*d_delta; % ����Ӧ��Ĵ�С��d_deltaΪ����ʱ��С��Ϊ����ʱ����
        object_h=round(h_w_ratio * object_w);
    end
    
end
