function [acmaCikisDegeri] = Opening(image)
image = im2bw(image);
structMatris = ones(3); %butun elemanlari bir olan yapi elemani
   [x, y] = size(image);
    for i=2: x-1
        for j=2: y-1
            output(i,j) = 1;
            temp = image(i-1:i+1,j-1:j+1);
            %ve islemi
            result = structMatris & temp;
            if min(min(result))==0
                output(i,j) = 0;
            end
             acmaCikisDegeri(i,j) = 0;
            %komþularý kontrol edilir
            for k=-1:1
                for l=-1:1
                    if(image(i+k,j+l) == 1)
                        acmaCikisDegeri(i,j) = 1;
                        break;
                    end
                end
            end
        end
    end
end