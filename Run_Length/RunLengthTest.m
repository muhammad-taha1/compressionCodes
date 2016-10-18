function RunLengthTest
% run-length encoding
encodedRes = Run_Length_Encoder('000000101010101011010111001')
% calculate prob for Huffman
p = computeProb(encodedRes);
p = sort(p,'descend');
p
% Huffman encoding
[HuffmanEncoded, valueSet, l] = encoder(encodedRes, p, encodedRes);
% Huffman decoding
HuffmanDecoded = decoder(HuffmanEncoded, valueSet, valueSet, l);
% Run-length decoding
decodedRes = Run_Length_Decoder(HuffmanDecoded)

end