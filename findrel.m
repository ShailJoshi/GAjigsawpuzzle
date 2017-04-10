function [B,n]=findrel(C,x,y)
B=zeros(4,1);
n=[];
if(C(x-1,y)~=0)
    B(1)=C(x-1,y);%left
    n=[n 1];
end
if(C(x+1,y)~=0)
    B(2)=C(x+1,y);%right
    n=[n 2];
end
if(C(x,y+1)~=0)
    B(3)=C(x,y+1);%down
    n=[n 3];
end
if(C(x,y-1)~=0)
    B(4)=C(x,y-1);%up
    n=[n 4];
end

end