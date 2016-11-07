function [probVector, keySet] = computeProbMarkov(runLengthEncodedStr, probOfZeroAtZero, probOfOneAtOne, max_run_length)
% This function takes as input the string returned by run-length encoder
% and calculates probabilities for each symbol, which will then be used by
% HuffmanCompression. It also generates KeySet for Huffman. This is used
% for Markov sources
probVector = [];
keySet = [];

for num = 1 : length(runLengthEncodedStr)
    
    % check if current number is in keySet
    numToAdd = true;
    for k = 1 : length(keySet)
        if (keySet(k) ~= runLengthEncodedStr(num) || length(keySet) == 0)
            numToAdd = true;
        else
            % number exists, so break out of the loop
            numToAdd = false;
            break;
        end
    end
    
    % it is always assumed that the previous run ends at one. Therefore the
    % next run has to start by first jumping from one to zero
    if (numToAdd)
        % Only add in keyset and compute prob if the number is not in
        % keyset
        keySet = [keySet, runLengthEncodedStr(num)];
        
        if (runLengthEncodedStr(num) == max_run_length)
            % no ones here
            numOfZeros = runLengthEncodedStr(num);
            % go from 1 to 0 and then stay at zero for the run
            prob = (1 - probOfOneAtOne)*probOfZeroAtZero^numOfZeros;
            probVector = [probVector, prob];
        else
            % get number of zeros for each char
            numOfZeros = runLengthEncodedStr(num);
            % got from 1 to 0, then stay at zero for the run and then go
            % from 0 to 1
            prob = (1 - probOfOneAtOne)*probOfZeroAtZero^numOfZeros*(1 - probOfZeroAtZero);
            probVector = [probVector, prob];
        end
    end
end
end