function probVector = computeProb(runLengthEncodedStr)
% This function takes as input the string returned by run-length encoder
% and calculates probabilities for each symbol, which will then be used by
% HuffmanCompression
probVector = [];

for num = 1 : length(runLengthEncodedStr)
    % get number of zeros for each char
    numOfZeros = str2num(runLengthEncodedStr(num));
    % Here we assume that the probability to get 0 is 0.95
    prob = 0.95^numOfZeros*0.05;
    probVector = [probVector, prob];
end
end