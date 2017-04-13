% r=1 left
% r=2 right
% r=3 up
% r=4 down
% ith row of BB contains 4 best buddies wrt to i in each direction
function [BB,BBLR,BBUD] = genBB(dissLUT,NN)
BB=zeros(NN,4);
BBLR=[,];
BBUD=[;];
for i=1:NN
    dissLUT(:,:,1)=dissLUT(:,:,1)+100000*eye(NN);
    dissLUT(:,:,2)=dissLUT(:,:,2)+100000*eye(NN);
    lutL=transpose(dissLUT(:,:,1));  %lutTemp(x,y) distance that x is left of y
    lutR=dissLUT(:,:,1);             %lutTemp(x,y) distance that x is right of y
    lutD=dissLUT(:,:,2);             %lutTemp(x,y) distance that x is below y
    lutU=transpose(dissLUT(:,:,2));  %lutTemp(x,y) distance that x is above y
    
    %for left of each
    [~,ind]=min(lutL(:,i));
    [~,ind2]=min(lutR(:,ind));
    if(ind2==i)
        BB(i,1)=ind;
        BBLR=[BBLR;[ind,i]];
    end
    %for right of each
    [~,ind]=min(lutR(:,i));
    [~,ind2]=min(lutL(:,ind));
    if(ind2==i)
        BB(i,2)=ind;
        
    end
    %for downwards of each
    [~,ind]=min(lutD(:,i));
    [~,ind2]=min(lutU(:,ind));
    if(ind2==i)
        BB(i,4)=ind;
        BBUD=[BBUD,[i;ind]];
    end
    %for upwards of each
    [~,ind]=min(lutU(:,i));
    [~,ind2]=min(lutD(:,ind));
    if(ind2==i)
        BB(i,3)=ind;
    end
end
end