% r is the relation between A and B
% r=1 left
% r=2 right
% r=3 up
% r=4 down
% A, B, r is relation with respect to B; so A, B, 3 means A is above B
% A and B are two pieces in RGB
function D=dissimilarity(A,B,r,L,W)
if(r==1)
    d=A(:,W,:)-B(:,1,:);
elseif(r==2)
    d=A(:,1,:)-B(:,W,:);
elseif(r==3)
    d=A(L,:,:)-B(1,:,:);
elseif(r==4)
    d=A(1,:,:)-B(L,:,:);
end
D=sqrt(sum((d(:)).^2));
end