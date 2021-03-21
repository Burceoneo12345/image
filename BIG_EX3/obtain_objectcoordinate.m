function [x1,y1,x2,y2]=obtain_objectcoordinate(center,width,height)
    %获得物体的坐标，输出为矩形的左下角x坐标、y坐标和右上角x坐标、y坐标
    x1=center(2)-floor((width-1)/2); %物体的左下角x坐标
    y1=center(1)-floor((height-1)/2); %物体的左下角y坐标
    x2=x1+width-1; %物体的右上角x坐标
    y2=y1+height-1; %物体的右上角y坐标
end
