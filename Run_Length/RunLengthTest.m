function RunLengthTest
% run-length encoding
% Note: max_run_length should be less than or equal to the size of input
% data
max_run_length = 20;
probOfZeroes = 0.95;
inputData = rand(1,32)>probOfZeroes
encodedRes = Run_Length_Encoder(inputData, max_run_length)%('000000101010101011010111001')

% calculate prob for Huffman
[p, keySet] = computeProb(encodedRes, probOfZeroes, max_run_length);

[p, idx] = sort(p,'descend');
sortedKeySet = [];
% sort keySet vector according to sorted probabilities index
for i = 1 : length(keySet)
    % add keySet value at idx(i) to sortedKeySet
    sortedKeySet = [sortedKeySet, keySet(idx(i))];
end

% Huffman encoding
[HuffmanEncoded, valueSet, l] = encoder(encodedRes, p, sortedKeySet)
% Huffman decoding
HuffmanDecoded = decoder(HuffmanEncoded, sortedKeySet, valueSet, l)
% Run-length decoding
decodedRes = Run_Length_Decoder(HuffmanDecoded, max_run_length)

end