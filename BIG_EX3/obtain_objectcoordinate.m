function [x1,y1,x2,y2]=obtain_objectcoordinate(center,width,height)
    %�����������꣬���Ϊ���ε����½�x���ꡢy��������Ͻ�x���ꡢy����
    x1=center(2)-floor((width-1)/2); %��������½�x����
    y1=center(1)-floor((height-1)/2); %��������½�y����
    x2=x1+width-1; %��������Ͻ�x����
    y2=y1+height-1; %��������Ͻ�y����
end
