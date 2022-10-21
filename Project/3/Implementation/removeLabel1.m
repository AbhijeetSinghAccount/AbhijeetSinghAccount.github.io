function O = removeLabel1(I)

%   Detailed explanation goes here

    O = I;
 
    
    if(I(267,46)>10)
        right=1;
    else
        right=0;
    end
    if(right==0)
         
        for R = 1:468
            countTotal = 0;
            count = 0;
            flag = 0;
            for C = 1:342
                pix = I(R, 320-C+1);

                if(pix > 2)
                    flag = 1;
                end
                if(flag == 1 && count == 0)
                    if(pix < 10)
                    countTotal = countTotal + 1;
                    end
                    if(countTotal > 50)
                    count = 1;
                    countTotal = 0;
                    end
                end

           if(count == 1)
               O(R, 320-C+1) = 0;
           end;

            end
        end
    else
        
        

        for R = 1:468
            countTotal = 0;
            count = 0;
            flag = 0;
            for C = 1:342
                pix = I(R, C);

                if(pix > 2)
                    flag = 1;
                end
                if(flag == 1 && count == 0)
                    if(pix < 10)
                    countTotal = countTotal + 1;
                    end
                    if(countTotal > 50)
                    count = 1;
                    countTotal = 0;
                    end
                end

           if(count == 1)
               O(R, C) = 0;
           end;

            end
        end
    end

end