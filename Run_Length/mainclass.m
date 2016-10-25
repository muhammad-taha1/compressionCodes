% Clear and close everything first
clear all
clc  
 Sourcedata = [0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
%Sourcedata = [0 0 0 1 0 0 1 0 0 1 0 1 0 1];
[Compr_Strng] = RunLength_Huffman_Encoder(Sourcedata);


