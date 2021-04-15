function [outimage] = meanFonksiyon(inimage, filtreBoyutu)
%Girdi resminin boyutlarinin alinmasi
[row,col,katman]=size(inimage);
if(katman>1)
    inimage=rgb2gray(inimage);
end
%Sinir degerleri için alinan veriler,goruntuyu genisletiyoruz
genisleme=(filtreBoyutu-1)/2+1;
baslama=((filtreBoyutu-1)/2);
%Filtre uygulanirken tasmalar olacagindan çikti resmini tekrar
%boyutlandiriyoruz.

outimage=zeros(row+genisleme,col+genisleme);  
[row1,col1]=size(outimage);
 

for i=2:row1-genisleme
    for j=2:col1-genisleme
        outimage(i,j)=inimage(i,j);
    end
end
%Döngü kullanarak filtreyi görüntü üzerinde gezdiriyoruz
for y=2:row1-baslama
  for x=2:col1-baslama
        komsu=outimage((y-baslama):y+baslama,(x-baslama):x+baslama);
       %belirlenmis olan noktanin filtre uygulandiktan sonraki yeni degeri
       %mean fonksiyonu 3x3 luk penceredeki deðerlerin ortalamasýný alýr.
       %(mean=ortalama demektir.)
       outimage(y,x)=mean(komsu(:));
  end
end
outimage=uint8(outimage);
end



