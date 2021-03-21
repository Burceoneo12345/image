function I=display_object(image,x1,y1,x2,y2,color)
    I=image;%图像矩阵
    
    % 对图像最上层两行和最下层两行赋颜色
    for i = x1:x2
        I(y1,i,:)=color;
        I(y1+1,i,:)=color;
        I(y2,i,:)=color;
        I(y2-1,i,:)=color;
    end
    
    % 对图像最左侧两行和最右侧两行赋颜色
    for i = y1:y2
        I(i,x1,:)=color;
        I(i,x1+1,:)=color;
        I(i,x2,:)=color;
        I(i,x2-1,:)=color;
    end
end
