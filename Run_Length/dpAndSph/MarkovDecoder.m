function decodedResult = MarkovDecoder(encoded, switchIdx, bit1, bit2, max_run_length, input)
% decodes MarkovEncoding. bit1 corresponds to encoding done on bit1Encoding
% and vice versa. Need to switch sources whenever the decoded string size
% hits switchIdx

% swithFlag = 0 when decodeing has to be done on bit1. Its 1 when decoding
% has to be done for bit2.
switchFlag = 0;
decodedResult = [];
toDecodeLength = 0;

% the start and end indexes indicate where for each particular run the
% decoding has to take place
startIdx = 1;

for i = 1 : length(encoded)
    endIdx = i;
    if (i == switchIdx(1))
        % decode upto the point indicated by switchIdx
        if (switchFlag == 0)
            decodedResult = [decodedResult, Run_Length_Decoder(encoded(startIdx : endIdx), max_run_length, bit1, bit2)];
        else
            decodedResult = [decodedResult, Run_Length_Decoder(encoded(startIdx : endIdx), max_run_length, bit2, bit1)];
        end
        startIdx = endIdx + 1;
        % switch switchFlag
        switchFlag = ~switchFlag;
        % remove first index from switchIdx
        switchIdx = switchIdx(2 : end);
        toDecodeLength = toDecodeLength + encoded(i);
    end
end
%decodedResult2 = Run_Length_Decoder(bit2Encoding, max_run_length, bit2, bit1);
    

end