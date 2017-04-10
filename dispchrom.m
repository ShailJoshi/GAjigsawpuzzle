function dispchrom(A,N,pieces)
s=size(pieces);
image=zeros(s(1)*N,s(2)*N,3);
for i=1:N
    for j=1:N
        image(1+(i-1)*s(1):i*s(1),1+(j-1)*s(2):j*s(2),:)=pieces(:,:,:,A(i,j));
    end
end
imshow(uint8(image));
end