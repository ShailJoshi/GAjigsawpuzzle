%entered image is recommended to be atleast 100s of pizels wide and long
clear
orig=imread('prashar.jpg');
N=10;                   %must be a divisor of image dimensions: 2,4,5,10,25,50 etc
p=15;                   %population
eltN=1;                 %no. of elites


%imshow(orig);
a=size(orig);
l=a(1);
l=(floor((l/100)))*100; % rounding to multiple of 100
w=a(2);
w=(floor((w/100)))*100;
origTr=orig(1:l,1:w,:);  % truncating image
%imshow(origTr);
NN=N*N; %total pieces
L=l/N;
W=w/N;
allPcs=zeros(L,W,3,NN);
j=1;
for i=1:NN              %divide image in NxN
    allPcs(:,:,:,i)=origTr((L*(ceil(i/N)-1)+1):L*(ceil(i/N)),(W*(j-1)+1):W*(j),:);
    %subplot(N,N,i);
    %imshow(uint8(allPcs(:,:,:,i)));  %show pieces of puzzle 
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
%% GA control
[BB,BBLR,BBUD]=genBB(dissLUT,NN);

P0=genPopulation(N,p);
figure
dispchrom(P0(:,:,1),N,allPcs)
title('A randomly generated chromosome of initial population');

%%
for gen=1:8
    contestants=1:p;  % avilable contestants at any point
    for i=1:p
        fitness(i)=fitnesscalc(P0(:,:,i),dissLUT,N);        %calculate fitness
    end
    minfit(gen)=min(fitness);    %minimization problem
    [~,elite]=sort(fitness);    
    elite=elite(1:eltN);           %remove top p as elite
    for i= 1:length(elite)
        newPop(:,:,i)=P0(:,:,elite(i));     %add elites to new population
    end
    contestants(elite)=[];      % remove elites from list of contestants
    newpopsize=length(elite);       %current size of new pop
    while(newpopsize~=p)        %untill new population reaches full size
        r=randperm(length(contestants));
        r=r(1:2);
        parents=contestants(r);     %select two parents at random
        C=crossover4(P0(:,:,parents(1)),P0(:,:,parents(2)),BBLR,BBUD,N,NN,dissLUT);
        newPop(:,:,newpopsize+1)=C;
        newpopsize=newpopsize+1;
    end
    P0=newPop;
end
figure
plot(minfit)
title('Fitness after each generation');
figure
dispchrom(P0(:,:,1),N,allPcs)   %display best image
title('Best image');