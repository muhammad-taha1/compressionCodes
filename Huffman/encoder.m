function compr_strng = encoder(data)
c_1 = '01';
c_2 = '1';
c_3 = '001';

compr_strng = []; 
dataDim = size(data)
    for i=1:dataDim(2)
        if data(i) == 0 
            compr_strng = [compr_strng, c_1] ;
        elseif data(i) == 1
            compr_strng = [compr_strng, c_2];
        else data(i) == 2
            compr_strng = [compr_strng, c_3];
        end
    end
end


        