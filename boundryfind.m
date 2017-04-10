function B=boundryfind(C,NN)
A=[0 1 0; 1 0 1; 0 1 0];
C=double(C~=0);
B=conv2(A,C);

B=B(2:NN+1,2:NN+1);
B=B~=0;
B=B-C;
B=B==1;
A=B;
B=[,];
for i=1:NN
    for j=1:NN
        if(A(i,j)==1)
            B=[B;[i,j]];
        end
    end
end
end