function [logCikisDegeri] =LogTransform(image, sabitDeger)
    image=im2double(image);

    [ satir,sutun,katman]=size(image);
    if(katman>1) 
        image=GrayImage(image);
    end

    logCikisDegeri=zeros(satir,sutun);

    for i=1:1:satir
        for j=1:1:sutun
            logCikisDegeri(i,j)=sabitDeger*log(1+image(i,j));
        end
    end
    logCikisDegeri=uint8(logCikisDegeri);
end

