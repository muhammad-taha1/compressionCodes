function compr_strng = encoder(data)
% Encodes input data according to Huffman algorithm 
% and returns the compressed string and the efficiency of the 
% compressed string

% Hard coded encoded values for digits 0, 1 and 2
c_1 = '00';
c_2 = '1';
c_3 = '01';

compr_strng = [];

    % Loop over input data and generate the compr_string according to 
    % the hard coded encoded values and compute the efficiency, based
    % on hard coded values for probability
    for i=1:length(data)
        if data(i) == 0 
            compr_strng = [compr_strng, c_1];
        elseif data(i) == 1
            compr_strng = [compr_strng, c_2];
        else
            compr_strng = [compr_strng, c_3];
        end
    end
end


        