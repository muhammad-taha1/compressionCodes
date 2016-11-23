function imgCompression()
%% Create Raw Image 
% 512 by 512 pixels binary image that has a sqaure 180 by 180 pixels square
% on left
rawImg = ones(512,512);  

for i= 1: 512 
    for j=1: 512 
        if (((i == 20) || (i == 200)) && ((j>=20) && (j<=200))) 
            rawImg(i,j) = 0; 
        elseif ( ((j == 20) || (j == 200)) && ((i>=20) && (i<=200)))
            rawImg(i,j) = 0;
        else 
            rawImg(i,j) = 1; 
        end
        
        % random tilted square
        if (abs(i-10) + abs(j-400) == 180)
            rawImg(i,j) = 0;
        end
        
        % rectangle from 180-250 at i and 10-100 in j
        if (((i == 360) || (i == 500)) && ((j>=20) && (j<=200))) 
            rawImg(i,j) = 0; 
        elseif ( ((j == 20) || (j == 200)) && ((i>=360) && (i<=500)))
            rawImg(i,j) = 0;
        end
        
    end
end

circImg = ones(512, 512);
for i= 1: 512
    for j=1: 512
        % create bolded circle in of radius 50 pixels, centered at 90,100
        if ((i-180)^2 + (j-200)^2 <= 100^2)
            circImg(i,j) = 0;
        end
        % remove all inner circle pixels
        if ((i-180)^2 + (j-200)^2 <= 98^2)
            circImg(i,j) = 1;
        end
        
        % create another circle in of radius 20 pixels, centered at 200,200
        if ((i-430)^2 + (j-100)^2 <= 40^2)
            circImg(i,j) = 0;
        end
        % remove all inner circle pixels
        if ((i-430)^2 + (j-100)^2 <= 39^2)
            circImg(i,j) = 1;
        end
        
        
        % create another circle in of radius 30 pixels, centered at 200,200
        % circle within square
        if ((i-400)^2 + (j-400)^2 <= 60^2)
            circImg(i,j) = 0;
        end
        % remove all inner circle pixels
        if ((i-400)^2 + (j-400)^2 <= 59^2)
            circImg(i,j) = 1;
        end
    end
end

rawImg = mod((rawImg + circImg), 2);

% mod2 addition inverts img, so invert it
rawImg = ~rawImg;

 
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