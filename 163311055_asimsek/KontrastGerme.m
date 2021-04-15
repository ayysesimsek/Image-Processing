function [outimage] = KontrastGerme(inimage)
    % G�r�nt�n�n boyut bilgileri al�n�yor ..
    [row,col,katman ]=size(inimage);
    
    % Girdi resminin gri seviye g�r�nt�ye d�n��t�r�lmesi
    if(katman>1)
        inimage=GrayCevir(inimage);
    end

    %��kt� resmine ilk de�er atama i�lemi yap�lmaktad�r.
    outimage=zeros(row ,col);
    
    %G�r�nt�deki en d���k ve en y�ksek gri seviye piksel de�erinin bulunmas�
    maxDeger=max(inimage(:));
    minDeger=min(inimage(:));

    outimage=double(outimage);
    for i=1:row
        for j=1:col
            %Kontrast germe i�lemi
            pay=double(inimage(i,j)-minDeger);
            payda=double(maxDeger-minDeger);     
            outimage(i,j)=(pay*255)/(payda);
        end
    end
    %Sonu�lar� kaydetmeden �nce g�r�nt� format�n�n uint8 'e d�nd�r�lmesi
    %sa�lan�l�yor.
    outimage=uint8(outimage);

end


