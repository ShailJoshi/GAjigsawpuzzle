function C=crossover2(A,B,BBLR,BBUD,N,NN)

ll=0;
rl=0;
ul=0;
bl=0;

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
        ABrelUD=[ABrelUD,[ArelUD(1,i);ArelUD(2,i)]];
    end
end



mud=size(ABrelUD);
mud=mud(2);
mlr=size(ABrelLR);
mlr=mlr(1);
matches=mlr+mud;
validlr=1:mlr;
validud=1:mud;
avlbl=1:NN;
C=zeros(2*N+1);


if(matches~=0)
    r=randi([1 matches]);
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
if(mlr<=0)
    ABrelLR=[-1,-2];
end
if(mud<=0)
    ABrelUD=[-3;-4];
end

while (length(avlbl)>0)
    edges=boundryfind(C,2*N+1);
    nb=length(edges);
    for i=1:nb
        curr=edges(i,:);
        if(bl-curr(1)<N && curr(1)-ul<N && curr(2)-ll<N && rl-curr(2)<N)
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
            
            [rel,~]=findrel(C,curr(1),curr(2));
            
            x=zeros(1,4);
            if(rel(1)~=0)
                
                if(ismember(rel(1),ABrelLR(:,2)))
                    b=ABrelLR(:,2)==rel(1);
                    x1=ABrelLR(:,1);
                    x1=x1(b);
                    if(ismember(x1,avlbl))
                        x(1)=x1;
                    end
                end
            end
            
            if(rel(2)~=0)
                if(ismember(rel(2),ABrelLR(:,1)))
                    b=ABrelLR(:,1)==rel(2);
                    x1=ABrelLR(:,2);
                    x1=x1(b);
                    if(ismember(x1,avlbl))
                        x(2)=x1;
                    end
                end
            end
            if(rel(3)~=0)
                if(ismember(rel(3),ABrelUD(1,:)))
                    b=ABrelUD(1,:)==rel(3);
                    x1=ABrelUD(2,:);
                    x1=x1(b);
                    if(ismember(x1,avlbl))
                        x(3)=x1;
                    end
                end
            end
            if(rel(4)~=0)
                if(ismember(rel(4),ABrelUD(2,:)))
                    b=ABrelUD(2,:)==rel(4);
                    x1=ABrelUD(1,:);
                    x1=x1(b);
                    if(ismember(x1,avlbl))
                        x(4)=x1;
                    end
                end
            end
            if(sum(x>0)>0)
                xn=sum(x>0);
                r=randi([1 xn]);
                b=x>0;
                x=x(b);
                x=x(r);
                C(curr(1),curr(2))=x;
                avlbl=avlbl(avlbl~=x);
                disp('from rel');
            else
                x=zeros(1,4);
                disp('from BB');
                if(rel(1)~=0)
                    if(ismember(rel(1),BBLR(:,2)))
                        b=BBLR(:,2)==rel(1);
                        x1=BBLR(:,1);
                        x1=x1(b);
                        if(ismember(x1,avlbl))
                            x(1)=x1;
                        end
                    end
                end
                if(rel(2)~=0)
                    if(ismember(rel(2),BBLR(:,1)))
                        b=BBLR(:,1)==rel(2);
                        x1=BBLR(:,2);
                        x1=x1(b);
                        if(ismember(x1,avlbl))
                            x(2)=x1;
                        end
                    end
                end
                if(rel(3)~=0)
                    if(ismember(rel(3),BBUD(1,:)))
                        b=BBUD(1,:)==rel(3);
                        x1=BBUD(2,:);
                        x1=x1(b);
                        if(ismember(x1,avlbl))
                            x(3)=x1;
                        end
                    end
                end
                if(rel(4)~=0)
                    if(ismember(rel(4),BBUD(2,:)))
                        b=BBUD(2,:)==rel(4);
                        x1=BBUD(1,:);
                        x1=x1(b);
                        if(ismember(x1,avlbl))
                            x(4)=x1;
                        end
                    end
                end
                if(sum(x>0)>0)
                    xn=sum(x>0);
                    r=randi([1 xn]);
                    b=x>0;
                    x=x(b);
                    x=x(r);
                    C(curr(1),curr(2))=x;
                    avlbl=avlbl(avlbl~=x);
                else
                    b=length(avlbl);
                    r=randi([1 b]);
                    x=avlbl(r);
                    C(curr(1),curr(2))=x;
                    avlbl=avlbl(avlbl~=x);
                end
                
                
            end
        end
    end
end
D=C>0;
D=C(D);
C=zeros(N);
C(:)=D;


end




