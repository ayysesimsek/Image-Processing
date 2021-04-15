function [outimage] = KontrastGerme(inimage)
    % Görüntünün boyut bilgileri alýnýyor ..
    [row,col,katman ]=size(inimage);
    
    % Girdi resminin gri seviye görüntüye dönüþtürülmesi
    if(katman>1)
        inimage=GrayCevir(inimage);
    end

    %Çýktý resmine ilk deðer atama iþlemi yapýlmaktadýr.
    outimage=zeros(row ,col);
    
    %Görüntüdeki en düþük ve en yüksek gri seviye piksel deðerinin bulunmasý
    maxDeger=max(inimage(:));
    minDeger=min(inimage(:));

    outimage=double(outimage);
    for i=1:row
        for j=1:col
            %Kontrast germe iþlemi
            pay=double(inimage(i,j)-minDeger);
            payda=double(maxDeger-minDeger);     
            outimage(i,j)=(pay*255)/(payda);
        end
    end
    %Sonuçlarý kaydetmeden önce görüntü formatýnýn uint8 'e döndürülmesi
    %saðlanýlýyor.
    outimage=uint8(outimage);

end


