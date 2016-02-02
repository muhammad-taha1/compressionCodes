clear all
clc

input = randsrc(1, 3, [0, 1, 2; 0.5, 0.3, 0.2]) ;
compr_strng = encoder(input);

output = decoder(compr_strng);


