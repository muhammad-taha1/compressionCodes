function imgCompression()

%img path
imgPath = 'F:\mcgill\7th semester\dp2\compressionCodes\Run_Length\testImages\test1.jpg';
compImgPath = 'F:\mcgill\7th semester\dp2\compressionCodes\Run_Length\testImages\compImg.mat';
%convert img to grayscale matrix
img = rgb2gray(imread(imgPath));
%convert the range of values (0-255) to binary
imgBin = imbinarize(img);
save('F:\mcgill\7th semester\dp2\compressionCodes\Run_Length\testImages\binImage.mat', 'imgBin');
[rSize, cSize] = size(imgBin);

% parameters to check performance
compSize = 0;
originalImgSize = rSize*cSize;

% apparently, white spots are indicated by 1 and black by 0. So now we flip
% these things (essentially make a negative of the image). The image will
% be flipped back again after decompression
for row = 1 : rSize
    for col = 1 : cSize
        imgBin(row, col) = ~imgBin(row, col);
    end
end
% figure
% imshow(img);
% get p0 and p1 from img
p1 = 0;
p0 = 0;
for row = 1 : rSize
    for col = 1 : cSize
        if (imgBin(row, col) == 1)
            p1 = p1 + 1;
        else
            p0 = p0 + 1;
        end
    end
end

p0 = p0/(rSize*cSize);
p1 = p1/(rSize*cSize);

% all compressed vectors are saved in file compImg.mat. Delete if it exists
% in order to not append existing file
if exist(compImgPath, 'file')==2
  delete(compImgPath);
end

% encode each row of the img, and save the result in compImg.mat file. each
% row is saved runLengthEncoded1, runLengthEncoded2 and so on. This file
% should then be used during decoding. Huffman should also be added in this
% for loop
for i = 1 : rSize
    runLengthEncoded = Run_Length_Encoder(imgBin(i,:), 31);
    
    b = dec2bin(runLengthEncoded);
    [m,n] = size(b);
    compSize = compSize + m*n;
    % find prob per row
%     for col = 1 : cSize
%         if (imgBin(row, col) == 0)
%             p0 = p0 + 1;
%         end
%     end
%     
%     p0 = p0/rSize;
    
%     % comput prob for huffman
%     [p, keySet] = computeProb(runLengthEncoded, p0, 31);
%     [p, idx] = sort(p,'descend');
%     sortedKeySet = [];
%     % sort keySet vector according to sorted probabilities index
%     for i = 1 : length(keySet)
%         % add keySet value at idx(i) to sortedKeySet
%         sortedKeySet = [sortedKeySet, keySet(idx(i))];
%     end
%     
%     if (length(p) == 1)
%         HuffmanEncoded = '0';
%         valueSet = {'0'};
%         l = [1];
%     else
%         % Huffman encoding
%         [HuffmanEncoded, valueSet, l] = encoder(runLengthEncoded, p, sortedKeySet);
%     end

%     toSave.(strcat('HuffmanEncoded', num2str(i)))=HuffmanEncoded;
%     toSave.(strcat('valueSet', num2str(i)))=valueSet;
%     toSave.(strcat('l', num2str(i)))=l;
toSave.(strcat('runLengthEncoded', num2str(i)))=runLengthEncoded;

    if exist(compImgPath, 'file')==2
        save(compImgPath, 'toSave', '-append');
    else
        save(compImgPath, 'toSave');
    end
end

% performance ratio printout
compRatio = compSize/originalImgSize
% decompression
compressedFile = load(compImgPath);
savedVar = compressedFile.('toSave');

decompressedImg = [];
for i = 1 : rSize
    row = savedVar.(strcat('runLengthEncoded', num2str(i)));
    decompressedImg = [decompressedImg; Run_Length_Decoder(row, 31)];
end

% invert the image
for row = 1 : rSize
    for col = 1 : cSize
        decompressedImg(row, col) = ~decompressedImg(row, col);
    end
end

imshow(decompressedImg);
end