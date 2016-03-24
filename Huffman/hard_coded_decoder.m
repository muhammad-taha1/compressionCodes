function data_HAT = decoder(compr_strng)
% Decodes the input compressed string according to the
% of the Huffman algorithm.

    dataDim = length(compr_strng);
    data_HAT = []; 
    while (dataDim ~= 0)
        % Loop over the input data and look for the hard coded values for
        % digits 0, 1 and 2. Delete the relevant chunk from the compr_strng
        % once its corresponding value has been found
        
        if compr_strng(1:1) == '1'
            % Case where the string has 1 at start.
            decomp_symb = 1;
            compr_strng = compr_strng(2: length(compr_strng));
            dataDim = length(compr_strng); 
            data_HAT = [data_HAT, decomp_symb]; 
        else 
            if compr_strng(2) == '0'
              % Case where the string has 00 at start.
              decomp_symb = 0; 
              compr_strng = compr_strng(3: length(compr_strng));
              dataDim = length(compr_strng); 
              data_HAT = [data_HAT, decomp_symb]; 
            else
               % The only remaining case according to our coded values.
               % Case where the string has 01 at start.
               decomp_symb = 2;
               compr_strng = compr_strng(3: length(compr_strng));
               dataDim = length(compr_strng); 
               data_HAT = [data_HAT, decomp_symb]; 
            end 
        end 
    end 
end