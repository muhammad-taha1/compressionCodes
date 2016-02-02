function data_HAT = decoder(compr_strng)
    dataDim = length(compr_strng)
    data_HAT= [] 
    while (dataDim ~= 0)
        if compr_strng(1:1) == '1'
            decomp_symb = 1 
            compr_strng = compr_strng(2: length(compr_strng));
            dataDim = length(compr_strng) 
            data_HAT = [data_HAT, decomp_symb]; 
        else 
            if compr_strng(2) == '1'  
              decomp_symb = 0 
              compr_strng = compr_strng(3: length(compr_strng));
              dataDim = length(compr_strng) 
              data_HAT = [data_HAT, decomp_symb]; 
            else 
               decomp_symb = 2
               compr_strng = compr_strng(4: length(compr_strng));
               dataDim = length(compr_strng) 
               data_HAT = [data_HAT, decomp_symb]; 
            end 
        end 
    end 
end