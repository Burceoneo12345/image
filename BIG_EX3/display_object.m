function I=display_object(image,x1,y1,x2,y2,color)
    I=image;%ͼ�����
    
    % ��ͼ�����ϲ����к����²����и���ɫ
    for i = x1:x2
        I(y1,i,:)=color;
        I(y1+1,i,:)=color;
        I(y2,i,:)=color;
        I(y2-1,i,:)=color;
    end
    
    % ��ͼ����������к����Ҳ����и���ɫ
    for i = y1:y2
        I(i,x1,:)=color;
        I(i,x1+1,:)=color;
        I(i,x2,:)=color;
        I(i,x2-1,:)=color;
    end
end
