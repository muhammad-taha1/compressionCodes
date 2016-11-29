function IntermediateSymbol = Run_Length_Encoder(inputData, maxLength, bit1, bit2)
% This encoder looks for a series of bit1s until it hits a bit2. The number of bit1s
% counted till the point of getting a bit2 is the run count for that
% corresponding run. So, 0001 compresses to 3, if bit1 = 0 and bit2 = 1.
% Also note that inputData is string of binary, entered via quotes. 
% Hitting a single bit2 gives the compression as 0.

compressedOutput = [];
% First add a bit2 at the end of inputData to ensure that there's a bit2 at the
% end of the file. This is to ensure that we do not encounter a run such as
% 0000, at the end of the file
inputData = [inputData, bit2];

% The process is repeated until input data is empty
while (~isempty(inputData))
    runCount = 0;
    for bit = 1 : length(inputData)
        if (inputData(bit) == bit1)
            % if the current bit is bit1, increment the run
            runCount = runCount + 1;
        elseif (inputData(bit) == bit2)
            % as soon as we hit a bit2, add the current run to compressedOutput
            % Remove the run from inputData and break out of the for loop
            compressedOutput = [compressedOutput, runCount];
            % The +2 here ensures that we take inputData after the runCount
            % and the 1 ending the run, for the next iteration
            inputData = inputData((runCount + 2) : end);
            break;
        end
        
        if (runCount == maxLength)
            % break out of loop if runCount equals maxLength
            compressedOutput = [compressedOutput, runCount];
            % we do +1 here since there's no 1 ending the run here
            inputData = inputData((runCount + 1) : end);
            break;
        end
        
    end
end

IntermediateSymbol = compressedOutput;

end