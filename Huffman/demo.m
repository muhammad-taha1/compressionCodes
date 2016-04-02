clc
clear all

source_symbols = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'];
p = [0.274, 0.171, 0.149, 0.130, 0.092, 0.057, 0.052, 0.042, 0.031, 0.002];
data = ['h', 'i', 'd', 'e']; 

% Perform encoding of the data above
[compr_strng, valueSet, l] = encoder(data, p, source_symbols);

% Print out the codebook
fprintf('The codebook for above source_symbols: \n');
for i = 1 : size(valueSet)
    fprintf('%s = %s \n', source_symbols(i), valueSet{i});
end

fprintf('\ndata to encode = %s \n', data);
% Print out the encoded string for the data
fprintf('\nThe encoded string for data above: \n');
fprintf('%s = %s \n', data, compr_strng);

% Decode data and print out the result
decoded_data = decoder(compr_strng, source_symbols, valueSet, l);
fprintf('\nThe decoded data = %s \n', decoded_data);

