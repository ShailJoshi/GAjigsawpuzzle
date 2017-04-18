function P=genPopulation(N,p)
P=zeros(N,N,p);
A=zeros(N,N);
for i=1:p
    A(:)=randperm(N*N);
    P(:,:,i)=A;
end
end