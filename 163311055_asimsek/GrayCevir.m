function [griSeviye] = GrayCevir(inimage)

    %"Size" ile g�r�nt�n�n boyut bilgilerinin alinmasi
    [satir,sutun,katman]=size(inimage);

    %Cikti resminin tan�mlanmas�
    griSeviye=zeros(satir,sutun);
    %Girdi resmi renkli bir g�r�nt� ise (RGB,katman=3) ise
    % gri seviye resme dondurulmasi    
    if(katman==1)
        msgbox('Resim zaten gri seviye,tekrar gri seviye d�n���m yap�lamaz.', 'Gri Resim', 'warn');
        griSeviye=inimage;
        return;
    else
        %Renkli g�r�nt� 0.2989 * R + 0.5870 * G + 0.1140 * B oranlar�nda 
        %kar�st�r�larak gri seviye g�r�nt� elde edilir.

        for m=1:satir
            for n=1:sutun
                griSeviye(m,n)=0.2989*inimage(m,n,1)...
                    +0.5870*inimage(m,n,2)...
                    +0.1140*inimage(m,n,3);
            end
        end
    end
    griSeviye = uint8(griSeviye);
end
