function [new_img]=auto_T(old_img)
new_img=double(old_img);
T=(min(new_img(:))+max(new_img(:)))/2;
done=false;
i=0;

while~done
    r1=find(new_img<=T);
    r2=find(new_img>T);
    Tnew=(mean(new_img(r1))+mean(new_img(r2)))/2;
    done=abs(Tnew-T)<1;
    T=Tnew;
    i=i+1;
end
new_img(r1)=0;
new_img(r2)=1;