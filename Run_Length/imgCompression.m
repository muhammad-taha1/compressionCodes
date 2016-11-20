function imgCompression()
%% Create Raw Image 
% 256 by 256 pixels binary image that has a sqaure 90 by 90 pixels square
% on left
rawImg = [];  
for i= 1: 256 
    for j=1: 256 
        if (((i == 10) || (i == 100)) && ((j>=10) && (j<=100))) 
            rawImg(i,j) = 0; 
        elseif ( ((j == 10) || (j == 100)) && ((i>=10) && (i<=100)))
            rawImg(i,j) = 0;
        else 
            rawImg(i,j) = 1; 
        end
    end
end

 
%% Image size
[rSize, cSize] = size(rawImg);

%% Parameters to check performance
compSize = 0;
originalImgSize = rSize*cSize;

% apparently, white spots are indicated by 1 and black by 0. So now we flip
% these things (essentially make a negative of the image). The image will
% be flipped back again after decompression
for row = 1 : rSize
    for col = 1 : cSize
        rawImg(row, col) = ~rawImg(row, col);
    end
end
% figure
% imshow(img);
% get p0 and p1 from img
p1 = 0;
p0 = 0;
for row = 1 : rSize
    for col = 1 : cSize
        if (rawImg(row, col) == 1)
            p1 = p1 + 1;
        else
            p0 = p0 + 1;
        end
    end
end

p0 = p0/(rSize*cSize);
p1 = p1/(rSize*cSize);


%% Encode img, and save the result in compImg.mat file
% The whole img is converted into an array(one row) and then reshaped
% after being also decompressed as one row. 

    rawImg = reshape(rawImg, 1, []); 
    runLengthEncoded = Run_Length_Encoder(rawImg, 31);
%% RL Compression Ratio
    b = dec2bin(runLengthEncoded);
    [m,n] = size(b);
    compSize = compSize + m*n;

     [p, keySet] = computeProb(runLengthEncoded, p0, 31);
     [p, idx] = sort(p,'descend');
     sortedKeySet = [];
     % sort keySet vector according to sorted probabilities index
     for i = 1 : length(keySet)
         % add keySet value at idx(i) to sortedKeySet
         sortedKeySet = [sortedKeySet, keySet(idx(i))];
     end
     
     if (length(p) == 1)
         HuffmanEncoded = '0';
         valueSet = {'0'};
         l = [1];
     else
         % Huffman encoding
         [HuffmanEncoded, valueSet, l] = encoder(runLengthEncoded, p, sortedKeySet);
     end
%% Huffman and RL Compression Ratio
compRatio = compSize/originalImgSize
HuffmanCompRatio = length(HuffmanEncoded)/ length(rawImg) 


%% Decompression

decompressedImg = [];

decompressedImg = [decompressedImg; Run_Length_Decoder(runLengthEncoded, 31)];
decompressedImg = reshape(decompressedImg, rSize, cSize); 

%% invert the image
for row = 1 : rSize
    for col = 1 : cSize
        decompressedImg(row, col) = ~decompressedImg(row, col);
    end
end

imshow(decompressedImg);
end