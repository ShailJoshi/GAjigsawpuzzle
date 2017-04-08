%entered image is recommended to be atleast 100s of pizels wide and long
clear
orig=imread('Koala.jpg');
%imshow(orig);
a=size(orig);
l=a(1);
l=(floor((l/100)))*100; % rounding to multiple of 100
w=a(2);
w=(floor((w/100)))*100;
origTr=orig(1:l,1:w,1:3);  % truncating image
%imshow(origTr);
N=5;
NN=N*N; %total pieces
L=l/N;
W=w/N;
allPcs=zeros(L,W,3,NN);
j=1;
for i=1:NN              %divide image in NxN
    allPcs(:,:,:,i)=origTr((L*(ceil(i/N)-1)+1):L*(ceil(i/N)),(W*(j-1)+1):W*(j),:);
    subplot(N,N,i);
    imshow(uint8(allPcs(:,:,:,i)));  %show pieces of puzzle 
    if(mod(j,N)==0)
        j=1;
    else
    j=j+1;
    end
end
%% dissimilarity and LUT
dissLUT=zeros(NN,NN,2); %dissimilarity look up table
%dissLUT stores right and down distances of each piece with every other
%piece. This allows reduction in complexity and time.

for i=1:NN
    for j=1:NN
        if(i~=j)
            dissLUT(i,j,1)=dissimilarity(allPcs(:,:,:,i),allPcs(:,:,:,j),2,L,W); %piece i is right of j
            dissLUT(i,j,2)=dissimilarity(allPcs(:,:,:,i),allPcs(:,:,:,j),4,L,W); %piece i is below j
        end
    end
end
