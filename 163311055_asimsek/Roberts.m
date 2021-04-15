function [cikis1,cikis2,cikis3] = Roberts(image,T)
    imageSingle = im2single(image);
    x_mask = [1 0; 0 -1];
    y_mask = [0 1;-1  0];
    cikis2 = imfilter(imageSingle,x_mask,'conv');
    cikis3 = imfilter(imageSingle,y_mask,'conv');
    M = sqrt(cikis2.^2+cikis3.^2);
    cikis1 = false(size(imageSingle));
    cikis1(M(:)>T) = 1;
    
    
    