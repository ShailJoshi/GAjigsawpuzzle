function C=crossover(A,B,BB,N,NN)

ll=0;
rl=0;
ul=0;
bl=0;
%
% RelatA=zeros(NN,4); %relations between neighbours in A
% RelatB=zeros(NN,4);
% for i=1:NN
%     T=A';
%     if(mod(i,N)~=1)
%         RelatA(T(i),1)=T(i-1);
%     end
%     if(mod(i,N)~=0)
%         RelatA(T(i),2)=T(i+1);
%     end
%     if(i>N)
%         RelatA(T(i),3)=T(i-N);
%     end
%     if(i<=NN-N)
%         RelatA(T(i),4)=T(i+N);
%     end
% end
% for i=1:NN
%     T=B';
%     if(mod(i,N)~=1)
%         RelatB(T(i),1)=T(i-1);
%     end
%     if(mod(i,N)~=0)
%         RelatB(T(i),2)=T(i+1);
%     end
%     if(i>N)
%         RelatB(T(i),3)=T(i-N);
%     end
%     if(i<=NN-N)
%         RelatB(T(i),4)=T(i+N);
%     end
% end
% Agreedrel=RelatA==RelatB & RelatA~=0; %relations agreed by both chromosomes

%Alternative
C=A';
C=C(:);
ArelUD(1,:)=C(1:NN-N);
ArelUD(2,:)=C(N+1:NN);
C=A;
C=C(:);
ArelLR(:,1)=C(1:NN-N);
ArelLR(:,2)=C(N+1:NN);

C=B';
C=C(:);
BrelUD(1,:)=C(1:NN-N);
BrelUD(2,:)=C(N+1:NN);
C=B;
C=C(:);
BrelLR(:,1)=C(1:NN-N);
BrelLR(:,2)=C(N+1:NN);

ABrelLR=[,];
for i=1:NN-N
    c=BrelLR(:,1)==ArelLR(i,1);
    b=BrelLR(:,2);
    if(ArelLR(i,2)==b(c))
        ABrelLR=[ABrelLR;[ArelLR(i,1),ArelLR(i,2)]];
    end
end

ABrelUD=[;];
for i=1:NN-N
    c=BrelUD(1,:)==ArelUD(1,i);
    b=BrelUD(2,:);
    if(ArelUD(2,i)==b(c))
        ABrelUD=[ABrelUD;[ArelUD(1,i),ArelUD(2,i)]];
    end
end


mud=length(ABrelUD);
mlr=length(ABrelLR');
matches=mlr+mud;
validlr=1:mlr;
validud=1:mud;
avlbl=1:NN;
C=zeros(2*N+1);


if(matches~=0)
    r=randi(matches);
    if(r>mlr)
        r=r-mlr;
        sel=ABrelUD(:,r);
        validud= validud(validud~=validud(r));
        mlr=mlr-1;
        C(N:N+1,N)=sel;
        ll=N;
        rl=N;
        ul=N;
        bl=N+1;
        
    else
        sel=ABrelLR(r,:);
        validlr=validlr(validlr~=validlr(r));
        mud=mud-1;
        C(N,N:N+1)=sel;
        ll=N;
        rl=N+1;
        ul=N;
        bl=N;
    end
    avlbl=avlbl(avlbl~=sel(1));
    avlbl=avlbl(avlbl~=sel(2));
else
    sel=randi(NN);
    disp('No matches');
    C(N,N)=sel;
    ll=N;
    rl=N;
    ul=N;
    bl=N;
    avlbl=avlbl(avlbl~=sel);
end
while (1)
    edges=findboundry(C,2*N+1);
    nb=length(edges);
    for i=1:nb
        curr=edges(i,:);
        if(curr(1)-bl<N && curr(1)-ul<N && curr(2)-ll<N && curr(2)-rl<N)
            if(curr(1)<ul)
                ul=curr(1);
            end
            if(curr(1)>bl)
                bl=curr(1);
            end
            if(curr(2)>rl)
                rl=curr(2);
            end
            if(curr(2)<ll)
                ll=curr(2);
            end
            [rel,n]=findrelative(C,curr(1),curr(2));
            if(length(n)==1)
                rel=rel(n);
                if(ismember(rel,avlbl))
                    if(n==1)
                        if(ismember(rel,ABrelLR(:,2)))
                             b=ABrelLR(:,2)==rel;
                             xA=ABrelLR(:,1);
                             xA=xA(b);
                             C(curr(1),curr(2))=xA;
                             avlbl=avlbl(avlbl~=xA);
                             validlr=validlr(validlr~=validlr(b));
                             mlr=mlr-1;
                        end
                    elseif(n==2)
                        if(ismember(rel,ABrelLR(:,1)))
                             b=ABrelLR(:,1)==rel;
                             xA=ABrelLR(:,2);
                             xA=xA(b);
                             C(curr(1),curr(2))=xA;
                             avlbl=avlbl(avlbl~=xA);
                             validlr=validlr(validlr~=validlr(b));
                             mlr=mlr-1;
                        end
                    elseif(n==3)
                         if(ismember(rel,ABrelUD(1,:)))
                             b=ABrelUD(1,:)==rel;
                             xA=ABrelUD(2,:);
                             xA=xA(b);
                             C(curr(1),curr(2))=xA;
                             avlbl=avlbl(avlbl~=xA);
                             validud=validud(validud~=validud(b));
                             mud=mud-1;
                         end
                    elseif(n==4)
                        if(ismember(rel,ABrelUD(2,:)))
                             b=ABrelUD(2,:)==rel;
                             xA=ABrelUD(1,:);
                             xA=xA(b);
                             C(curr(1),curr(2))=xA;
                             avlbl=avlbl(avlbl~=xA);
                             validud=validud(validud~=validud(b));
                             mud=mud-1;
                        end
                    end
                end
                
            elseif(length(n)==2)
                rel=
                
            elseif(length(n)==3)
                
                
            elseif(length(n)==4)
                
            end
            
        end
    end
    
end
end

