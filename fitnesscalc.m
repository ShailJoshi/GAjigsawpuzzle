function F=fitnesscalc(A,dissLUT,N)
F=0;
    for i=1:N
        for j=1:N
            F=F + dissLUT(A(i,(j*(j<N)+1)),A(i,j),1)*(j<N) + dissLUT(A(i*(i<N)+1,j),A(i,j),2)*(i<N);            % dissLUT(i,j,1) piece i is right of j and dissLUT(i,j,2) i is below j
        end
    end
end