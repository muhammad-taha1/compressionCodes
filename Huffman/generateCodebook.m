function [l, CB] = generateCodebook(CB_to_split_indices)

% initialize
CB = [0; 1];
l = [1, 1];

% Loop backwards in CB_to_split_indices array.
% This is done because the last index of this array 
% has only 2 elements of probability and hence corresponds
% with the initial CB of [0; 1]
for i = length(CB_to_split_indices) : -1 : 1
    
    % Current index to split
    index_to_split = CB_to_split_indices(i);
    
    % split and make new l. Duplicate l at index to split and 
    % add one to increase l for the indices being spit.
    l = [l(1 : index_to_split - 1);
        l(index_to_split) + 1;
        l(index_to_split) + 1;
        l(index_to_split + 1 : end)];
    
    % Create a column of zeros. To be appended in CB
    zero_column = zeros(length(CB), 1);
    
    % Append CB with zero column
    CB = [CB, zero_column];
    
    % Create a copy of the row to split from CB
    splitted_row_copy = CB(index_to_split, :);
    
    % Insert splitted_row_copy in CB at index to split
    CB = [CB(1 : index_to_split, :);
        splitted_row_copy;
        CB(index_to_split + 1 : end, :)];
    
    % Set the values of row to split as 0 and 1, the vector l defining
    % the position of where the value has to be changed.
    CB(index_to_split, l(index_to_split)) = 0;
    CB(index_to_split + 1, l(index_to_split)) = 1; 
    
end

end