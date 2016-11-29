function decodedResult = Run_Length_Decoder(compr_String, max_run_length, bit1, bit2)
% The decoder considers the fact that each digit in compr_String indicates
% that many number of bit1s followed by bit2. 
tempDecodedResult = [];

% loop over all bits in compr_String
for idx = 1 : length(compr_String)
    zeroCount = 0;
    
    while (zeroCount ~= compr_String(idx))
        % Keep appending bit1 to tempDecodedResult and incrementing zeroCount,
        % until we have the same number of bit1s in tempDecodedResult as
        % specified by the index in compr_String
        tempDecodedResult = [tempDecodedResult, bit1];
        zeroCount = zeroCount + 1;
    end
    if (max_run_length ~= compr_String(idx))
        % Only append bit2 when the number in compr_String is not equal max_run_length
        % Append the terminating bit2 for each run in tempDecodedResult
        tempDecodedResult = [tempDecodedResult, bit2];
    end
end

% Remove the last bit2 from the decoded result. This bit2
% was initially added by the encoder to to aid with the compression
tempDecodedResult = tempDecodedResult(1 : end - 1);
decodedResult = tempDecodedResult;
end