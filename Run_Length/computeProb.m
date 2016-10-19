function [probVector, keySet] = computeProb(runLengthEncodedStr, probOfZero, max_run_length)
% This function takes as input the string returned by run-length encoder
% and calculates probabilities for each symbol, which will then be used by
% HuffmanCompression. It also generates KeySet for Huffman
probVector = [];
keySet = runLengthEncodedStr(1);

for num = 1 : length(runLengthEncodedStr)
    if (runLengthEncodedStr(num) == max_run_length)
        % no ones here
        prob = probOfZero^numOfZeros;
        probVector = [probVector, prob];
    else 
        % get number of zeros for each char
        numOfZeros = str2num(runLengthEncodedStr(num));
        % Here we assume that the probability to get 0 is 0.95
        prob = probOfZero^numOfZeros*(1 - probOfZero);
        probVector = [probVector, prob];
    end
    
    % check if current number is in keySet
    numToAdd = false;
    for k = 1 : length(keySet)
        if (keySet(k) ~= runLengthEncodedStr(num))
            numToAdd = true; 
        else
            numToAdd = false;
        end
    end
    
    if (numToAdd)
        keySet = [keySet, runLengthEncodedStr(num)];
    end
    
end
end