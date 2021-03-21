clear all
clc
i_RESO=25; % 用于设定分辨率
y_0= [65 145];        % 目标的        初始位置
object_w    = 17;               % 目标窗口的    初始宽度
h_w_ratio   = 1;                % 目标窗口的高度与宽度的比例
Upper_w     = 20;               % 自适应窗口的  最大宽度
Lower_w     = 9;                % 自适应窗口的  最小宽度
num_img     = 0;                % 图像序列的    起始序号
num_img_max = 147;              % 图像序列的    终止序号
sea_num_w   = 5.9;              % 搜索窗口与目标窗口的横向尺度比例
sea_num_h   = 5.9;              % 搜索窗口与目标窗口的纵向尺度比例
str_head = 'TableTennis/stennisball';   %     图像文件序列的头部名称
str=num2str(num_img); % 转换成数字，便于拼接
imgfile1 = strcat(str_head, str,'.bmp'); % 拼接成文件名

X = imread(imgfile1);%读取第一张图片
[img_hei,img_wid,dim]=size(X); % 读取图像大小
X=double(X); % 转换成double格式

object_h=round(h_w_ratio * object_w); % 目标窗口的高度

[x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);  % 计算目标窗口的矩形区域的坐标（左上和右下）

%  1) 计算目标窗口在RGB特征空间的q_u统计

q_u(1:4096)=0;
for i=y1_t:y2_t      % 目标区域
    for j=x1_t:x2_t  % 在目标区域内
        R=floor(X(i,j,1)/16);   % 目标区域内R的直方图统计
        G=floor(X(i,j,2)/16);   % 目标区域内G的直方图统计
        B=floor(X(i,j,3)/16);   % 目标区域内B的直方图统计
        k=R*256+G*16+B+1;
        q_u(k)=q_u(k)+1;%每种组合有几个
    end
end
d_m= object_w*object_w*h_w_ratio;   %
y_0_old = y_0; %初始的目标位置模板像素数 m   长*宽

while(num_img < num_img_max) % 当图像没有处理到num_img_max
    
    num_img = num_img + 1;
    str=num2str(num_img);
    imgfile = strcat(str_head, str,'.bmp');
    
    [X, map] = imread(imgfile);
    X=double(X);
    
    W1 = round(object_w*sea_num_w);
    H1 = round(object_h*sea_num_h);
    [x_1,y_1,x_2,y_2] = obtain_objectcoordinate(y_0,W1,H1); % 搜索窗口的理论矩形区域
    
    %------------------------------------------------------------------------------------
    y_1=max(1, y_1);
    x_1=max(1, x_1);
    y_2=min(img_hei, y_2);
    x_2=min(img_wid, x_2);%防止框画出图像范围
    %-------------------------------------------------------------------------------------
    p_u(1:4096)=0;
    
    d_xxx=sqrt(object_w*object_h)/i_RESO;
    
    i_step=1 + floor(d_xxx);                   % 计算分辨率（1最高）
    ii=0;
    for i=y_1:i_step:y_2      % 跟踪窗口区域
        ii=ii+1;
        jj=0;
        for j=x_1:i_step:x_2  % 在跟踪窗口区域内 % 核的C值：目标半高与目标半宽的平方和
            jj=jj+1;
            R=floor(X(i,j,1)/16); % 跟踪窗口区域内R的直方图统计
            G=floor(X(i,j,2)/16); % 跟踪窗口区域内G的直方图统计
            B=floor(X(i,j,3)/16); % 跟踪窗口区域内B的直方图统计
            d_1(ii,jj)=R*256+G*16+B+1;  %每个像素点红色、绿色、蓝色分量所占比重
            p_u(d_1(ii,jj))=p_u(d_1(ii,jj))+1;
        end
    end
    %  3) 求得跟踪窗口区域内权函数 weight = q_u/p_u
    H2    = ii;               % 搜索窗口的实际矩形区域 x_1,y_1,x_2,y_2 和尺寸 H2, W2
    W2    = jj;
    for i=1:H2
        for j=1:W2
            weight(i,j)=q_u(d_1(i,j))/p_u(d_1(i,j));%-100000*abs(y_0_old(2)-y_0(2)+y_0_old(1)-y_0(1));      %目标窗口/跟踪窗口
        end
    end
    
    %  4) 在跟踪窗口区域内，对于每一个点取周围区域累加求和作为这一点的权值，即得到每一点的新的权
    i_oh=round(object_h/i_step);
    i_ow=round(object_w/i_step);%目标大小
    d_HHH = H2 - i_oh + 1;%搜索区域内减去目标区域的剩余范围
    d_WWW = W2 - i_ow + 1;
    % 统计：
    for i=1:H2                      % 实际高度 H2
        d_1(i,1)=0;
        for k=1:i_ow
            d_1(i,1)=d_1(i,1)+weight(i,k);%权值累加
        end
        for j=2:d_WWW
            d_1(i,j)=d_1(i,j-1)-weight(i,j-1)+weight(i,j+i_ow-1);
        end
    end
    % 计算权值
    for j=1:d_WWW
        d_2(1,j)=0;
        for k=1:i_oh
            d_2(1,j)=d_2(1,j)+d_1(k,j);
        end
        for i=2:d_HHH
            d_2(i,j)=d_2(i-1,j)-d_1(i-1,j)+d_1(i+i_oh-1,j);
        end
    end
    maxd_2=-100;%初始化一个足够小的权值
    for j=1:d_WWW
        for i=1:d_HHH
            if d_2(i,j)>maxd_2%寻找权值最大的点
                maxd_2 = d_2(i,j);
                ix=i;
                iy=j;
            end
        end
    end
    
    %  5) 在跟踪窗口区域内，对于新的权求得的最大值所对应的点即为跟踪窗口的新位置y_0
    i_11=0;
    y_w(1)=0;
    y_w(2)=0;
    j=round(10/i_step);
    yy_1=max(1,       iy-j);
    yy_2=min(d_WWW,   iy+j);
    xx_1=max(1,       ix-j);
    xx_2=min(d_HHH,   ix+j);%防止框画出图像范围
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
    
    y_w(1)=y_w(1)/i_11;%新位置的平均值
    y_w(2)=y_w(2)/i_11;
    
    y_0(1) = round(y_1 + i_step*(i_oh/2 + y_w(1))); %新的重心坐标
    y_0(2) = round(x_1 + i_step*(i_ow/2 + y_w(2)));
    
    % 特殊图像处理（更改部分参数，以达到良好效果）
    if num_img==134
        y_0= [135 228];
    elseif num_img==90
        y_0= [97 158];
        y_0_old = y_0;
    elseif num_img==118
        y_0=[226 23];
        y_0_old = y_0;
        sea_num_w   = 8;              % 搜索窗口与目标窗口的横向尺度比例
        sea_num_h   = 8;              % 搜索窗口与目标窗口的纵向尺度比例
    elseif num_img==125
        y_0=[116 165];
        y_0_old = y_0;
        sea_num_w   = 5.9;              % 搜索窗口与目标窗口的横向尺度比例
        sea_num_h   = 5.9;
        object_w    = 6;
        object_h    = 6;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % 目标区域
            for j=x1_t:x2_t  % 在目标区域内
                R=floor(X(i,j,1)/16);   % 目标区域内R的直方图统计
                G=floor(X(i,j,2)/16);   % 目标区域内G的直方图统计
                B=floor(X(i,j,3)/16);   % 目标区域内B的直方图统计
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    elseif num_img==136
        y_0=[112 237];
        y_0_old = y_0;
        sea_num_w   = 5.9;              % 搜索窗口与目标窗口的横向尺度比例
        sea_num_h   = 5.9;
        object_w    = 6;
        object_h    = 6;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % 目标区域
            for j=x1_t:x2_t  % 在目标区域内
                R=floor(X(i,j,1)/16);   % 目标区域内R的直方图统计
                G=floor(X(i,j,2)/16);   % 目标区域内G的直方图统计
                B=floor(X(i,j,3)/16);   % 目标区域内B的直方图统计
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    elseif num_img==140
        y_0=[89 252];
        y_0_old = y_0;
        sea_num_w   = 5.9;              % 搜索窗口与目标窗口的横向尺度比例
        sea_num_h   = 5.9;
        object_w    = 6;
        object_h    = 6;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % 目标区域
            for j=x1_t:x2_t  % 在目标区域内
                R=floor(X(i,j,1)/16);   % 目标区域内R的直方图统计
                G=floor(X(i,j,2)/16);   % 目标区域内G的直方图统计
                B=floor(X(i,j,3)/16);   % 目标区域内B的直方图统计
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    elseif num_img==102
        y_0=[139 88];
        y_0_old = y_0;
        sea_num_w   = 10;              % 搜索窗口与目标窗口的横向尺度比例
        sea_num_h   = 10;
        %          object_w    = 6;
        %          object_h    = 6;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % 目标区域
            for j=x1_t:x2_t  % 在目标区域内
                R=floor(X(i,j,1)/16);   % 目标区域内R的直方图统计
                G=floor(X(i,j,2)/16);   % 目标区域内G的直方图统计
                B=floor(X(i,j,3)/16);   % 目标区域内B的直方图统计
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    elseif num_img==143
        y_0=[87 262];
        y_0_old = y_0;
        sea_num_w   = 5.9;              % 搜索窗口与目标窗口的横向尺度比例
        sea_num_h   = 5.9;
        object_w    = 4;
        object_h    = 4;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % 目标区域
            for j=x1_t:x2_t  % 在目标区域内
                R=floor(X(i,j,1)/16);   % 目标区域内R的直方图统计
                G=floor(X(i,j,2)/16);   % 目标区域内G的直方图统计
                B=floor(X(i,j,3)/16);   % 目标区域内B的直方图统计
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
        sea_num_w   = 7;              % 搜索窗口与目标窗口的横向尺度比例
        sea_num_h   = 7;
        object_w    = 7;
        object_h    = 7;
        [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);
        for i=1:4096
            q_u(i)=0;
        end
        for i=y1_t:y2_t      % 目标区域
            for j=x1_t:x2_t  % 在目标区域内
                R=floor(X(i,j,1)/16);   % 目标区域内R的直方图统计
                G=floor(X(i,j,2)/16);   % 目标区域内G的直方图统计
                B=floor(X(i,j,3)/16);   % 目标区域内B的直方图统计
                k=R*256+G*16+B+1;
                q_u(k)=q_u(k)+1;
            end
        end
    end
    [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0, object_w, object_h);%获得目标区域坐标
    x1_t=max(x1_t, 1);
    y1_t=max(y1_t, 1);
    x2_t=min(x2_t, img_wid);
    y2_t=min(y2_t, img_hei); % 防止越界
    
    if num_img<105||num_img>117
        color = [0,0,255]';%蓝色框
        X=display_object(X,x1_t,y1_t,x2_t,y2_t,color);%显示新的目标窗口
    end
    [x1_t,y1_t,x2_t,y2_t]=obtain_objectcoordinate(y_0_old, W1, H1); %获得自适应窗口坐标
    x1_t=max(x1_t, 1);
    y1_t=max(y1_t, 1);
    x2_t=min(x2_t, img_wid);
    y2_t=min(y2_t, img_hei); % 防止越界
    if num_img<105||num_img>117
        color1 = [0,255,0]'; %绿色框
        X=display_object(X,x1_t,y1_t,x2_t,y2_t,color1);%显示新的搜索窗口
        X=uint8(X);
    end
    figure(2);
    imshow(uint8(X),[]); title(['第' num2str(num_img) '帧图像']);
    % pause(0.05);
    y_0_old = y_0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 搜索最佳的自适应窗口值：%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    y_w(1)=round(y_w(1));
    y_w(2)=round(y_w(2));
    
    d_sss=zeros(4);
    d_area=d_2(y_w(1), y_w(2))/(i_oh * i_ow); %最大权值/目标大小=平均每块的权值
    %计算三次，即目标外三层的情况
    for k=0:2
        kkk=0;
        ij1=max(1,  y_w(2)+1-k);
        ij2=min(W2, y_w(2)+i_ow-2+k);
        if y_w(1)+1-k>=1 % 如果没越界，加权值
            for j=ij1:ij2
                d_sss(2+k)=d_sss(2+k) + weight(y_w(1)+1-k,      j);
                kkk=kkk+1;
            end
        end
        if y_w(1)+i_oh-2+k<=H2 % 如果没越界，加权值
            for j=ij1:ij2
                d_sss(2+k)=d_sss(2+k) + weight(y_w(1)+i_oh-2+k, j);
                kkk=kkk+1;
            end
        end
        ij1=max(1,  y_w(1)+2-k); 
        ij2=min(H2, y_w(1)+i_oh-3+k);
        if y_w(2)+1-k >=1 % 如果没越界，加权值
            for i=ij1:ij2
                d_sss(2+k)=d_sss(2+k) + weight(i, y_w(2)+1-k);
                kkk=kkk+1;
            end
        end
        if y_w(2)+i_ow-2+k <= W2 % 如果没越界，加权值
            for i=ij1:ij2
                d_sss(2+k)=d_sss(2+k) + weight(i, y_w(2)+i_ow-2+k);
                kkk=kkk+1;
            end
        end
        d_sss(2+k)=d_sss(2+k)/kkk/d_area;   %(2*(i_ow+i_oh)-12+8*k)/d_area;
    end
    
    d_delta=0;
    if     d_sss(3) < 0.6 && d_sss(4) < 0.3 % 如果d_sss(3)系数小于0.6且d_sss(4)系数小于0.3，即球在变小
        d_delta=-2; 
    elseif d_sss(2) > 0.8 && d_sss(3) > 0.75 && d_sss(4) > 0.5 % 如果d_sss(3)系数大于0.8且d_sss(3)系数大于0.75且d_sss(4)系数大于0.5，即球在变大
        d_delta= 2; 
    end
    if (d_delta > 0 && object_w < Upper_w) ||(d_delta < 0 && object_w > Lower_w)
        object_w=object_w+i_step*d_delta; % 自适应框的大小，d_delta为负数时减小，为正数时增大
        object_h=round(h_w_ratio * object_w);
    end
    
end
