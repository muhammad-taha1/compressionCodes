function RunLengthTest
% run-length encoding
inputData = rand(1,10)>0.95
encodedRes = Run_Length_Encoder(inputData, 4)%('000000101010101011010111001')
% calculate prob for Huffman
[p, keySet] = computeProb(encodedRes, 0.95);

p = sort(p,'descend');

% Huffman encoding
[HuffmanEncoded, valueSet, l] = encoder(encodedRes, p, keySet)
% Huffman decoding
HuffmanDecoded = decoder(HuffmanEncoded, keySet, valueSet, l)
% Run-length decoding
decodedRes = Run_Length_Decoder(HuffmanDecoded)

end