function [compr_strng, efficiency] = encoder(data)
% Encodes input data according to Huffman algorithm 
% and returns the compressed string and the efficiency of the 
% compressed string

% Hard coded encoded values for digits 0, 1 and 2
c_1 = '01';
c_2 = '1';
c_3 = '001';

compr_strng = [];
efficiency = 0;

    % Loop over input data and generate the compr_string according to 
    % the hard coded encoded values and compute the efficiency, based
    % on hard coded values for probability
    for i=1:length(data)
        if data(i) == 0 
            compr_strng = [compr_strng, c_1];
            efficiency = efficiency + 2 * 0.5;
        elseif data(i) == 1
            compr_strng = [compr_strng, c_2];
            efficiency = efficiency + 1 * 0.3;
        else
            compr_strng = [compr_strng, c_3];
            efficiency = efficiency + 3 * 0.2;
        end
    end
end


        