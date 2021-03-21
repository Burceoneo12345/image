function quyu_grow(img,point)
global moban
x=point(1);
y=point(2);
if moban(x,y)~=3
    return
end
if img(x,y)~=1
    moban(x,y)=0;
    return
else 
   moban(x,y)=1;
   quyu_grow(img,[x-1;y]);
   quyu_grow(img,[x+1;y]);
   quyu_grow(img,[x;y+1]);
   quyu_grow(img,[x;y-1]);
end
