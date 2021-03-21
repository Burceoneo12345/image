function varargout = GUI1(varargin)
%GUI1 MATLAB code file for GUI1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('Property','Value',...) creates a new GUI1 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GUI1_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI1('CALLBACK') and GUI1('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI1.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI1

% Last Modified by GUIDE v2.5 02-Dec-2020 08:58:43

% Begin initialization code - DO NOT EDIT
clc;
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI1_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI1 is made visible.
function GUI1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
% Choose default command line output for GUI1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;







% --------------------------------------------------------------------
function EX1_Callback(hObject, eventdata, handles)
% hObject    handle to EX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Load1_Callback(hObject, eventdata, handles)
% hObject    handle to Load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I1 = imread('image1.jpeg');
axes(handles.axes1);
imshow(I1);
axes(handles.axes2);
imshow(I1);


% --------------------------------------------------------------------
function RGB2G_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
[~,~,l] = size(old_img);
if(l ==3)
    img = rgb2gray(old_img);
    axes(handles.axes2);
    imshow(img);
else
    msgbox('�ⲻ��RGBͼ��','warning','error');
end

% --------------------------------------------------------------------
function RGB2BW_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2BW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
[~,~,l] = size(old_img);
if(l == 3)
    img = rgb2gray(old_img);
    img = imbinarize(img);
    axes(handles.axes2);
    imshow(img);
else
    msgbox('�ⲻ��RGBͼ��','warning','error');
end

% --------------------------------------------------------------------
function RGB2ind_Callback(hObject, eventdata, handles)
% hObject    handle to RGB2ind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img=getimage;
[X,map]=rgb2ind(old_img,5);%����ɫͼ��ת��Ϊ����ͼ��
axes(handles.axes2);
imshow(X,map); 


% --------------------------------------------------------------------
function show_all_Callback(hObject, eventdata, handles)
% hObject    handle to show_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
A = getimage;

[~,~,l] = size(A);
if(l == 3)
	figure;
    subplot(321),imshow(A);title('ԭͼ');
    % 1.rgb���Ҷ�
    B = rgb2gray(A);
    subplot(322),imshow(B);title('rgb���Ҷ�');
    % 2.�Ҷȵ���ֵ
    C = imbinarize(B);
    subplot(323),imshow(C);title('�Ҷȵ���ֵ');
    % 3.rgb������
    [D,map] = rgb2ind(A,150);
    subplot(324),imshow(D,map);title('rgb������');
    % 4.������rgb
    E = ind2rgb(D,map);
    subplot(325),imshow(E);title('������rgb');
    % 5.�������Ҷ�
    F = ind2gray(D,map);
    subplot(326),imshow(F);title('�������Ҷ�');
else
    msgbox('�ⲻ�ǲ�ɫͼ����ѡ���ɫͼ����Ϊ��ʾ','warning','error');
end




% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function img_mov_Callback(hObject, eventdata, handles)
% hObject    handle to img_mov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes2);
img = getimage;
x0 = str2double(inputdlg('������ƽ������ˮƽ��'));
y0 = str2double(inputdlg('������ƽ��������ֱ��'));
mov_rot = [1,0,x0;0,1,y0;0,0,1];%ƽ�ƾ���
[h,w,l]=size(img);
new_h = h + x0;
new_w = w + y0;
new_mov_img = ones(new_h,new_w,l)*255;
for i = 1 : h
    for j = 1 : w
        r=[i,j,1];
        r=mov_rot*r';
        new_mov_img(r(1),r(2),:)=img(i,j,:);
    end
end
axes(handles.axes2);
imshow(uint8(new_mov_img)); 
% --------------------------------------------------------------------
function img_ver_mir_Callback(hObject, eventdata, handles)
% hObject    handle to img_ver_mir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
img=getimage;
[~,w,~]=size(img);
ver_mirror_img = img;
for i = 1 : w
    ver_mirror_img(1:end,i,:)=ver_mirror_img(end:-1:1,i,:);
end
axes(handles.axes2);
imshow(ver_mirror_img)

% --------------------------------------------------------------------
function img_hor_mir_Callback(hObject, eventdata, handles)
% hObject    handle to img_hor_mir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
img=getimage;
[h,~,~]=size(img);
hor_mirror_img=img;
for i = 1 : h
    hor_mirror_img(i,1:end,:)=hor_mirror_img(i,end:-1:1,:);
end
axes(handles.axes2);
imshow(hor_mirror_img)

% --------------------------------------------------------------------
function img_resize_Callback(hObject, eventdata, handles)
% hObject    handle to img_resize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);

scale = str2double(inputdlg('���������ű���������1��'));
old_img=getimage;
[row,col,dim]=size(old_img);

% �������
if scale < 0
    disp('��������Ϊ��ֵ������������');
    new_img=[];
    return;
end
% ��ͼ���С
new_img = uint8(zeros(floor(row*scale),floor(col*scale),dim));
for d=1:dim
    if scale >= 1
        % �Ŵ�
        % ��һ������ֵ������ͼ���k*k���ӿ��С�
        % kron����Ҳ���Բο�
        for i=1:size(new_img(:,:,d),1)
            for j=1:size(new_img(:,:,d),2)
                new_img(i,j,d) = old_img(ceil(i/scale),ceil(j/scale),d);
            end
        end
    else
        % ��С
        % ȡԭͼ��ż���棩���к�ż���棩���й����µ�ͼ��
        for i=1:size(new_img(:,:,d),1)
            for j=1:size(new_img(:,:,d),2)
                new_img(i,j,d) = old_img(floor(i/scale),floor(j/scale),d);
            end
        end
    end
end
figure
imshow(new_img)
axis on
title('���ź�ͼƬ');
figure
imshow(old_img)
axis on
title('ԭͼ');
% --------------------------------------------------------------------
function img_rotate_line_Callback(hObject, eventdata, handles)
% hObject    handle to img_rotate_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
img = getimage;
theta = str2double(inputdlg('��������ת�Ƕ�'));
new_rotate_img = imrotate(img,theta);
% theta = theta*pi/180;
% [h,w,l]=size(img);
% rotate_rot = [cos(theta), sin(theta), 0; -sin(theta), cos(theta), 0; 0, 0, 1];
% rot_h = floor(w*sin(theta) + h*cos(theta)) + 1;
% rot_w = floor(w*cos(theta) + h*sin(theta)) + 1;
% cent1 = [h/2; w/2; 1];
% cent2 = [rot_h/2; rot_w/2; 1];
% new_rotate_img = ones(rot_h, rot_w,l)*256;
% for i = 1:rot_h
%         for j = 1:rot_w
%             r = [i,j,1];
%             pos = round(rotate_rot*(r'-cent2)+cent1);
%             if pos(1)>=1 && pos(1)<=h && pos(2)>=1 && pos(2)<=w
%                 new_rotate_img(i, j,:) = img(pos(1), pos(2),:);
%             end
%         end        
% end
axes(handles.axes2);
imshow(uint8(new_rotate_img));

% --------------------------------------------------------------------
function img_rotate_double_line_Callback(hObject, eventdata, handles)
% hObject    handle to img_rotate_double_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
img = getimage;
theta = str2double(inputdlg('��������ת�Ƕ�'));
new_rotate_img = imrotate(img,theta);
% theta = theta*pi/180;
% [h,w,l]=size(img);
% rotate_rot = [cos(theta), sin(theta), 0; -sin(theta), cos(theta), 0; 0, 0, 1];
% rot_h = floor(w*sin(theta) + h*cos(theta)) + 1;
% rot_w = floor(w*cos(theta) + h*sin(theta)) + 1;
% cent1 = [h/2; w/2; 1];
% cent2 = [rot_h/2; rot_w/2; 1];
% new_rotate_img = ones(rot_h, rot_w,l)*256;
% for i = 1:rot_h
%         for j = 1:rot_w
%             r = [i,j,1];
%             pos = round(rotate_rot*(r'-cent2)+cent1);
%             x = floor(pos(1));
%             y = floor(pos(2));
%             u = pos(1)-x; 
%             v = pos(2)-y; 
%              if(x <= h-1 && y <= w-1 && x >= 2 && y >= 2)
%                new_rotate_img(i, j,:)=(1-u)*(1-v)*img(x,y,:) + u*(1-v)*img(x+1,y,:) +...
%                 (1-u)*v*img(x,y+1,:) + u*v*img(x+1,y+1,:);
%              end
%         end        
% end
axes(handles.axes2);
imshow(new_rotate_img);


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function img_log_Callback(hObject, eventdata, handles)
% hObject    handle to img_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
C = str2double(inputdlg('����������仯�е�Cֵ'));
s = mat2gray(old_img,[0 255]);
new_img = mat2gray(C*log(1+double(s)),[0 1]);
axes(handles.axes2);
imshow(new_img);

% --------------------------------------------------------------------
function img_exp_Callback(hObject, eventdata, handles)
% hObject    handle to img_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
b = str2double(inputdlg('������ָ���仯�е�bֵ'));
c = str2double(inputdlg('������ָ���仯�е�cֵ'));
a = str2double(inputdlg('������ָ���仯�е�aֵ'));
s = mat2gray(old_img,[0 255]);
new_img = mat2gray(b.^(c.*(s-a)-1),[0 1]);
axes(handles.axes2);
imshow(new_img);

% --------------------------------------------------------------------
function img_his_Callback(hObject, eventdata, handles)
% hObject    handle to img_his (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
[row,col,ll]=size(old_img);
if (ll == 3)
old_img = rgb2gray(old_img);
end
new_img=double(old_img);
img_temp=zeros(row,col);
l=row*col;
temp1=zeros(1,256);
temp2=zeros(1,256);
for i=1:row
    for j=1:col
        temp1(new_img(i,j)+1)=temp1(new_img(i,j)+1)+1;%�洢�����Ҷȼ��ĵ���������temp1��
    end
end
%�õ����Ҷȼ��ı���
temp1=temp1/l;
%���ۻ���ֱ��ͼ
for k=1:256
    for j=1:k
        temp2(k)=temp2(k)+temp1(j);
    end
    temp2(k)=ceil(255*temp2(k));
end
for i=1:row
    for j=1:col
        img_temp(i,j)=temp2(new_img(i,j)+1);
    end
end
new_img=uint8(img_temp);
axes(handles.axes2);
imshow(new_img);


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
B=questdlg('ȷ�Ϲر�����ͼ�δ�����ʾϵͳ?','��ʾ','Yes','No','Yes');
switch B
   case 'Yes'
   close(gcf);
   clear all;
   clc; 
end


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function imnoise_show_Callback(hObject, eventdata, handles)
% hObject    handle to imnoise_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
img = getimage;

salt_parameter = str2double(inputdlg('�����뽷�������Ĳ���'));
gaussian_1 = str2double(inputdlg('�������˹�����ľ�ֵ'));
gaussian_2 = str2double(inputdlg('�������˹�����ķ���'));

%��������
img_salt_pepper = imnoise(img ,'salt & pepper',salt_parameter); 

%��˹����
img_gaussian  = imnoise(img,'gaussian',gaussian_1,gaussian_2);

%��������
img_poisson = imnoise(img,'poisson');

figure
subplot(221)
imshow(img)
title('ԭͼ');
subplot(222)
imshow(img_salt_pepper)
title('���뽷���������ͼ��');
subplot(223)
imshow(img_gaussian)
title('�����˹�������ͼ��');
subplot(224)
imshow(img_poisson)
title('���벴���������ͼ��');

% --------------------------------------------------------------------
function image_median_Callback(hObject, eventdata, handles)
% hObject    handle to image_median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
img = getimage;

salt_parameter = str2double(inputdlg('�����뽷�������Ĳ���'));
gaussian_1 = str2double(inputdlg('�������˹�����ľ�ֵ'));
gaussian_2 = str2double(inputdlg('�������˹�����ķ���'));

%��������
img_salt_pepper = imnoise(img ,'salt & pepper',salt_parameter); 

%��˹����
img_gaussian  = imnoise(img,'gaussian',gaussian_1,gaussian_2);

%��������
img_poisson = imnoise(img,'poisson');

%���������˲�
[h,w,l] = size(img_salt_pepper);
new_img1 = zeros(h,w,l);
for i = 2 : h-1
    for j = 2 : w-1
        m = [img_salt_pepper(i-1:i+1,j-1,:);img_salt_pepper(i-1:i+1,j,:);img_salt_pepper(i-1:i+1,j+1,:)];
        new_img1(i,j,:)=median(m);
    end
end
new_img1 = uint8(new_img1);
figure;
subplot(121)
imshow(img_salt_pepper)
title('���뽷���������ͼ��');
subplot(122)
imshow(new_img1)
title('������ֵ�˲�֮���ͼ��');

%��˹�����˲�
[h,w,l] = size(img_gaussian);
new_img2 = zeros(h,w,l);
for i = 2 : h-1
    for j = 2 : w-1
        m = [img_gaussian(i-1:i+1,j-1,:);img_gaussian(i-1:i+1,j,:);img_gaussian(i-1:i+1,j+1,:)];
        new_img2(i,j,:)=median(m);
    end
end
new_img2 = uint8(new_img2);
figure;
subplot(121)
imshow(img_gaussian)
title('�����˹�������ͼ��');
subplot(122)
imshow(new_img2)
title('������ֵ�˲�֮���ͼ��');

%���������˲�
[h,w,l] = size(img_poisson);
new_img3 = zeros(h,w,l);
for i = 2 : h-1
    for j = 2 : w-1
        m = [img_poisson(i-1:i+1,j-1,:);img_poisson(i-1:i+1,j,:);img_poisson(i-1:i+1,j+1,:)];
        new_img3(i,j,:)=median(m);
    end
end
new_img3 = uint8(new_img3);
figure;
subplot(121)
imshow(img_poisson)
title('���벴���������ͼ��');
subplot(122)
imshow(new_img3)
title('������ֵ�˲�֮���ͼ��');


% --------------------------------------------------------------------
function image_lf_Callback(hObject, eventdata, handles)
% hObject    handle to image_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
D0 = str2double(inputdlg('�����������ͨ�˲��Ľ�ֹƵ��'));
[row, col,l] = size(old_img);
if (l==3)
old_img = rgb2gray(old_img);
end
fp=double(old_img);
% ��ͼ����и���Ҷ�任
F1 = fft2(fp);
G1 = fftshift(F1); % ���ݾ���ƽ��
% ���������ͨ�˲�����
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
%�����˲�
G = G1.*H;
G = ifftshift(G);%����Ƶ��
% ������Ҷ�任
gp = ifft2(G);
% ����õ���ͼ��
new_img = uint8(real(gp));
axes(handles.axes2);
imshow(new_img);

% --------------------------------------------------------------------
function image_Butterworth_Callback(hObject, eventdata, handles)
% hObject    handle to image_Butterworth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
D0 = str2double(inputdlg('���������������˹��ͨ�˲��Ľ�ֹƵ��'));
N = str2double(inputdlg('���������������˹��ͨ�˲��Ľ���'));
[row, col,l] = size(old_img);
if (l==3)
old_img = rgb2gray(old_img);
end
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
axes(handles.axes2);
imshow(new_img);

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
[sfilename,spathname]=uiputfile({'*.jpg';'*.png';'*.bmp';'*.tif';'*.*'},'����ͼ��');
if ~isequal([sfilename,spathname],[0,0])
    sfilefullname=[spathname sfilename];%���ȫ·������һ�ַ���
    axes(handles.axes2);
    T=getimage;%���������2��ͼ����Ϣ������T
    imwrite(T,sfilefullname);
else
   return
end

% --------------------------------------------------------------------
function Load2_Callback(hObject, eventdata, handles)
% hObject    handle to Load2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.*';'*.png';'*.jpg';'*.bmp';'*.tif'},'����ͼ��');
if isequal(filename,0)||isequal(pathname,0)
    %errordlg('û�д��ļ���','error');
    return;
else
    file=[pathname,filename];
    global S %����һ��ȫ�ֱ����������ʼͼ��·�������ڻ�ԭ
    S=file;
    I=imread(file);
    axes(handles.axes1);%��TagֵΪaxes1����������Ϊ��ǰ
    imshow(I); 
    axes(handles.axes2);%��TagֵΪaxes1����������Ϊ��ǰ
    cla reset%���ԭ������
    imshow(I); 
    clear T map PSF;
end


% --------------------------------------------------------------------
function gray2BW_Callback(hObject, eventdata, handles)
% hObject    handle to gray2BW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
[~,~,l] = size(old_img);
if(l == 1)
    img = imbinarize(old_img);
    axes(handles.axes2);
    imshow(img);
else
    msgbox('�ⲻ�ǻҶ�ͼ��','warning','error');
end


% --------------------------------------------------------------------
function img_Prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to img_Prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
[h,w,l] = size(old_img);
if(l == 3)
old_img = rgb2gray(old_img); 
end
new_img = zeros(h,w);
old_img = double(old_img);
rot_x = [1,1,1;0,0,0;-1,-1,-1];
rot_y = [1,0,-1;1,0,-1;1,0,-1];
for i=2:h-1
    for j=2:w-1
        G = [old_img(i-1:i+1,j-1),old_img(i-1:i+1,j),old_img(i-1:i+1,j+1)];
        Gx = sum(sum(G.*rot_x));
        Gy = sum(sum(G.*rot_y));
        new_img(i,j) = sqrt(Gx^2+Gy^2);
    end
end
new_img = uint8(new_img);
axes(handles.axes2);
imshow(new_img);

% --------------------------------------------------------------------
function img_Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to img_Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
[h,w,l] = size(old_img);
if(l == 3)
old_img = rgb2gray(old_img); 
end
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
axes(handles.axes2);
imshow(new_img);


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Roberts_egde_Callback(hObject, eventdata, handles)
% hObject    handle to Roberts_egde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t = str2double(inputdlg('������Roberts���ӱ�Ե������ֵ'));
axes(handles.axes1);
old_img = getimage;
[row,col,l] = size(old_img);
if(l == 3)
old_img = rgb2gray(old_img); 
end
new_img = uint8(zeros(row,col));
old_img = double(old_img);
for i=1:row-1
    for j=1:col-1
        Gx = old_img(i+1,j+1)-old_img(i,j);
        Gy = old_img(i,j+1)-old_img(i+1,j);
        if uint8(sqrt(Gx^2+Gy^2)) >= t
            new_img(i,j) = 255;
        end
    end
end
axes(handles.axes2);
imshow(new_img);
% --------------------------------------------------------------------
function Sobel_egde_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel_egde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t = str2double(inputdlg('������Sobel���ӱ�Ե������ֵ'));
axes(handles.axes1);
old_img = getimage;
[row,col,l] = size(old_img);
if(l == 3)
old_img = rgb2gray(old_img); 
end
new_img = uint8(zeros(row,col));
old_img = double(old_img);
for i=2:row-1
    for j=2:col-1
        Gx = old_img(i+1,j-1)+2*old_img(i+1,j)+old_img(i+1,j+1)-(old_img(i-1,j-1)+2*old_img(i-1,j)+old_img(i-1,j+1));
        Gy = old_img(i-1,j+1)+2*old_img(i,j+1)+old_img(i+1,j+1)-(old_img(i-1,j-1)+2*old_img(i,j-1)+old_img(i+1,j-1));
        if uint8(sqrt(Gx^2+Gy^2)) >= t
            new_img(i,j) = 255;
        end
    end
end
axes(handles.axes2);
imshow(new_img);

% --------------------------------------------------------------------
function Prewitt_egde_Callback(hObject, eventdata, handles)
% hObject    handle to Prewitt_egde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t = str2double(inputdlg('������Prewitt���ӱ�Ե������ֵ'));
axes(handles.axes1);
old_img = getimage;
[row,col,l] = size(old_img);
if(l == 3)
old_img = rgb2gray(old_img); 
end
new_img = uint8(zeros(row,col));
old_img = double(old_img);
for i=2:row-1
    for j=2:col-1
        Gx = old_img(i+1,j-1)+old_img(i+1,j)+old_img(i+1,j+1)-(old_img(i-1,j-1)+old_img(i-1,j)+old_img(i-1,j+1));
        Gy = old_img(i-1,j+1)+old_img(i,j+1)+old_img(i+1,j+1)-(old_img(i-1,j-1)+old_img(i,j-1)+old_img(i+1,j-1));
        if uint8(sqrt(Gx^2+Gy^2)) >= t
            new_img(i,j) = 255;
        end
    end
end
axes(handles.axes2);
imshow(new_img);

% --------------------------------------------------------------------
function find_edge_Callback(hObject, eventdata, handles)
% hObject    handle to find_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('�߽�׷��ʱ���������ͼƬ����������ٶ�','��ʾ');
point_y=10;
point_x=10;
axes(handles.axes1);
old_img = getimage;
old_img = rgb2gray(old_img);
old_img = imbinarize(old_img);
offsetr=[-1,0,1,0];
offsetc=[0,1,0,-1];
next_search_dir_table=[4,1,2,3];
next_dir_table=[2,3,4,1];
start=-1;
boundary=-2;


[rv,cv]=find((old_img(point_y-1:end-2,point_x:end)==0)&(old_img(point_y:end-1,point_x:end)>0));%�ҳ���ʼ��
rv=rv+point_y-1;
cv=cv+point_x;

startr=rv(1);%��ʼ��
startc=cv(1);
old_img=im2double(old_img);
old_img(startr,startc)=start;


cur_p=[startr,startc];
init_departure_dir=-1;
done=0;%��ɱ�־
next_dir=2;%��ʼ��Ѱ����
while ~done
    dir=next_dir;
    found_neighbour=0;
    for i=1:length(offsetr)
        offset=[offsetr(dir),offsetc(dir)];
        neighbour=cur_p+offset;
        if(old_img(neighbour(1),neighbour(2)))~=0%�ҵ��µı�Ե��
            if(old_img(cur_p(1),cur_p(2))==start) && (init_departure_dir==-1)
                init_departure_dir=dir;%�����뿪��ʼ��ķ��� 
            elseif (old_img(cur_p(1),cur_p(2))==start)&&(init_departure_dir==dir)
                done=1;
                found_neighbour=1;%�ҵ���һ���߽��
                break;
            end
            next_dir=next_search_dir_table(dir);
            found_neighbour=1;
            if old_img(neighbour(1),neighbour(2))~=start
                old_img(neighbour(1),neighbour(2))=boundary;
            end
            cur_p=neighbour;
            break;
        end
        
        dir=next_dir_table(dir);
    end
    % =====
    if found_neighbour == 0
        break;
    end
    % =====
end
bi=old_img==boundary;
old_img(:)=0;
old_img(bi)=1;
old_img(startr,startc)=1;
new_img = imbinarize(old_img);
axes(handles.axes2);
imshow(new_img);

% --------------------------------------------------------------------
function water_shed_Callback(hObject, eventdata, handles)
% hObject    handle to water_shed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
old_img = getimage;
[~,~,l] = size(old_img);
if(l == 3)
old_img = rgb2gray(old_img); 
end
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
axes(handles.axes2);
imshow(new_img);
