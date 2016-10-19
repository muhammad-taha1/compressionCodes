function RunLengthTest
% run-length encoding
max_run_length = 3;
inputData = rand(1,10)>0.51
encodedRes = Run_Length_Encoder(inputData, max_run_length)%('000000101010101011010111001')
% calculate prob for Huffman
[p, keySet] = computeProb(encodedRes, 0.95, max_run_length);

p = sort(p,'descend')

% Huffman encoding
[HuffmanEncoded, valueSet, l] = encoder(encodedRes, p, keySet)
% Huffman decoding
HuffmanDecoded = decoder(HuffmanEncoded, keySet, valueSet, l)
% Run-length decoding
decodedRes = Run_Length_Decoder(HuffmanDecoded, max_run_length)

end