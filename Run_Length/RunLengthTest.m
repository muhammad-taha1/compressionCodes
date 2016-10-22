function RunLengthTest
% run-length encoding
% Note: max_run_length should be less than or equal to the size of input
% data
max_run_length = 24;
probOfZeroes = 0.85;
inputData = rand(1,60)>probOfZeroes
encodedRes = Run_Length_Encoder(inputData, max_run_length)%('000000101010101011010111001')
% calculate prob for Huffman
[p, keySet] = computeProb(encodedRes, probOfZeroes, max_run_length);

p = sort(p,'descend')
% Huffman encoding
[HuffmanEncoded, valueSet, l] = encoder(encodedRes, p, keySet)
% Huffman decoding
HuffmanDecoded = decoder(HuffmanEncoded, keySet, valueSet, l)
% Run-length decoding
decodedRes = Run_Length_Decoder(HuffmanDecoded, max_run_length)

end