function [B,n]=findrel(C,x,y)
B=zeros(4,1);
n=[];
if(C(x,y-1)~=0)
    B(2)=C(x,y-1);%left
    n=[n 1];
end
if(C(x,y+1)~=0)
    B(1)=C(x,y+1);%right
    n=[n 2];
end
if(C(x+1,y)~=0)
    B(4)=C(x+1,y);%down
    n=[n 3];
end
if(C(x-1,y)~=0)
    B(3)=C(x-1,y);%up
    n=[n 4];
end

end