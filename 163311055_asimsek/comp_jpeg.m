function comp_jpeg(target_output)
 
%imgGray openfile fonksiyonumla ald���m g�rsel, filename de onun tam yolu+ad�
global imgGray;
global FileName;
 
%imfinfo fonksiyonu yolunu+ad�n�+uzant�s�n� verdi�imiz g�rselin bilgilerini al�r
%info.FileSize diyerek de byte cinsinden boyutuna eri�ebiliriz. bunu 1024'e
%b�lersek de kb cinsinden de�erini elde ederiz.
infoUncompressed =amp;nbsp;imfinfo(FileName);
tFileSize1 = (infoUncompressed.FileSize/1024);
 
%g�rselin boyutunu al�p 2 elemanl� tek boyutlu bir matrise at�yorum
[h,w] = size(imgGray);
 
% y�zde 50 s�k��t�rma �zelli�ine sahip matrisimiz
matQuality=[...
 16 11 10 16 24 40 51 61
 12 12 14 19 26 58 60 55
 14 13 16 24 40 57 69 56
 14 17 22 29 51 87 80 62
 18 22 37 56 68 109 103 77
 24 35 55 64 81 104 113 92
 49 64 78 87 103 121 120 101
 72 92 95 98 112 100 103 99];
 
% g�rselin kopyas�n� al�p onun �zerinde �al��al�m istedim.
%ve g�rseli double'a �evirdik
imgCopy = double(imgGray);
% bu ad�m �nemli. matrisin her bir eleman�nda 128 ��karmam�z gerekiyor ki
% quantization i�lemi sonucu ��kan de�erlerimiz abs�rd bir aral�kta olmas�n
imgCopy = imgCopy-128;
% 8x8 boyutunda ge�ici matris olu�turduk. bunu g�rselimizdeki bloklar�n
% yerini tutmas� i�in kullanaca��z.
temp = zeros(8,8);
% geldik esas meselenin d�nd��� yere. kelime oyunlu cin �aka time.
% "for i=1:8:h", i de�erini 1 den ba�lat (matlab'da 0 dan ba�lamaz)
% sekizer sekizer h de�erine gelene kadar artt�r anlam�na gelir.
% bu sayede g�rselimizi sekizer bloklar halinde gezebiliyoruz.
for i=1:8:h
 for j=1:8:w
% ge�ici matrisimize g�rselimizdeki 8x8 blo�u ald�k. dct'den ge�irdik.
% quality matrisimize b�ld�k. g�rselimizdeki o b�lgeye geri ge�ici matrisi
% entegre ettik. en son da g�rselimizdeki de�erleri round ile tamsay� yapt�k.
 temp = imgCopy(i:i+7, j:j+7);
 temp = dct2(temp);
 temp = temp ./ matQuality;
 imgCopy(i:i+7, j:j+7) = temp;
 end
end
imgCopy = round(imgCopy);
 
% yine ge�ici matrise blo�u ald�k. quality matrisi ile �arpt�k.
% bu sefer inverse dct yapt�k. 128 ekledik de�erlere. g�rselimizin
% ilgili blo�una ge�ici matrisi yab��t�rd�k.
for i=1:8:h
 for j=1:8:w
 temp = imgCopy(i:i+7, j:j+7);
 temp = temp .* matQuality;
 temp = idct2(temp);
 temp = temp + 128;
 imgCopy(i:i+7, j:j+7) = temp;
 end
end
 
% imwrite fonksiyonu bir matrisi resim olarak kaydetmemizi sa�lar.
% iki parametre al�r. ilk parametre g�rselimiz, ikinci dosya ad�+uzant�s�d�r.
imwrite(imgCopy, 'img.jpg');
 
% benim gui'mde axis var o y�zden g�rselimi orada g�steriyorum. isterseniz
% onu silip figure ekleyebilirsiniz.
axes(target_output);
imshow(imgCopy);
 
% son yazd���m�z g�rselin bilgilerini teee en ba�taki gibi al�yoruz.
infoCompressedImage = imfinfo('img.jpg');
tFileSize2 = infoCompressedImage.FileSize/1024;

end