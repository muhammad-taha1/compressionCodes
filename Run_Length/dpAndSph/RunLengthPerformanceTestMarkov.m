function RunLengthPerformanceTestMarkov
% run-length encoding
% Note: max_run_length should be less than or equal to the size of input
% data
max_run_length = [3, 7, 15, 31, 63];
probOfZeroAtZero = 0.95;
probOfOneAtOne = 0.7;
pZeroIid = 0.95;
iterationsPerMRL = 50;

% following variables will store data for plotting
RLcompressionRatioToPlot = [];

for mrl_idx = 1 : length(max_run_length)
    % iterations for each test
    
    % variables for each iteration
    RLcompressionRatio = 0;
    
    for j = 1 : iterationsPerMRL
        
        input = MarkovSource(10^4, probOfZeroAtZero, probOfOneAtOne);
        [encoded, switchIdx] = MarkovEncoder(input, max_run_length(mrl_idx), 0, 1);
        
        decoded = MarkovDecoder(encoded, switchIdx, 0, 1, max_run_length(mrl_idx));
        
        if ((length(input) ~= length(decoded)) | (input ~= decoded))
            input
            decoded
            fprintf('fix me!');
        end
        
        %Expected Length Testing
        B = dec2bin(encoded);
        
        [m,n] = size(B);
        
        % percentage of compression achieved through Run Length
        RLcompressionRatio = RLcompressionRatio +((m*n)/length(input));
    end
    % average out all variables
    RLcompressionRatio = RLcompressionRatio/iterationsPerMRL;
    % Now store the averaged out values for plots
    RLcompressionRatioToPlot = [RLcompressionRatioToPlot RLcompressionRatio];
    
end
% Plot for Compression ratio comparison
figure
stem(max_run_length, RLcompressionRatioToPlot);
grid on
legend('Run-Length');
xlabel('max run-length size');
ylabel('Compression ratio');
title(strcat('Compression ratio comparison, probOfZeroAtZero = ',num2str(probOfZeroAtZero)));
% hist(HuffmanCompSize/1000, 20);
% grid on
% title('Huffman compression efficiency');
end