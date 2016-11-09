function imgCompression()

%img path
imgPath = 'C:\Users\Muhammad Taha\Desktop\img_gray.jpg';
%convert img to grayscale matrix
img = rgb2gray(imread(imgPath));
%convert the range of values (0-255) to binary
imgBin = imbinarize(img);
[rSize, cSize] = size(imgBin);

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
if exist('compImg.mat', 'file')==2
  delete('compImg.mat');
end

% encode each row of the img, and save the result in compImg.mat file. each
% row is saved runLengthEncoded1, runLengthEncoded2 and so on. This file
% should then be used during decoding. Huffman should also be added in this
% for loop
for i = 1 : rSize
    runLengthEncoded = Run_Length_Encoder(imgBin(i,:), 5);
    toSave.(strcat('runLengthEncoded', num2str(i)))=runLengthEncoded;
    if exist('compImg.mat', 'file')==2
        save('compImg.mat', 'toSave', '-append');
    else
        save('compImg.mat', 'toSave');
    end
end

% decompression
compressedFile = load('compImg.mat');
savedVar = compressedFile.('toSave');
row = savedVar.('runLengthEncoded1');

decompressedImg = [];
for i = 1 : rSize
    row = savedVar.(strcat('runLengthEncoded', num2str(i)));
    decompressedImg = [decompressedImg; Run_Length_Decoder(row, 5)];
end

imshow(decompressedImg);
end