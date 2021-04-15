function [dctCikisDegeri] = DCT(image)
doubleResim=double(image)/255;

for i=1:8
    matris=DCTSikistirmaMatrisi(i);
    dctMat=dctmtx(8);
    B=blkproc(doubleResim,[8 8],'P1*x*P2',dctMat,dctMat');
    islem1=blkproc(B,[8 8],'P1.*x',matris);
    dctCikisDegeri=blkproc(islem1,[8 8],'P1*x*P2',dctMat',dctMat);
        
        %wspolczynnik kompresji
        %b - ilosc jedynek w masce
        b=0;
        for m=1:8
            for n=1:8
                if matris(m,n)==1
                    b=b+1;
                end
            end
        end

        
end
imwrite(dctCikisDegeri,'DCTYeniResim.JPG');
end

