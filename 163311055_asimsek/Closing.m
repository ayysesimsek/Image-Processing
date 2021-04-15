function [output] = Closing(image)
image = im2bw(image);
[x, y]  = size(image);
structMatris = ones(3); %butun elemanlari bir olan yapi elemani

for i=2: x-1
        for j=2: y-1
            DI(i,j) = 0;
            %kom?ular? kontrol edilir
            for k=-1:1
                for l=-1:1
                    if(image(i+k,j+l) == 1)
                        DI(i,j) = 1;
                        break;
                    end
                end
            end
             output(i,j) = 1;
            temp = image(i-1:i+1,j-1:j+1);
            %ve islemi
            result = structMatris & temp;
            if min(min(result))==0
                output(i,j) = 0;
            end
        end
    end


  end
    
end