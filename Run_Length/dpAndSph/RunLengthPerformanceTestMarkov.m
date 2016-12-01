function RunLengthPerformanceTestMarkov
% run-length encoding
% Note: max_run_length should be less than or equal to the size of input
% data
max_run_length = [3, 7, 15, 31, 63];
probOfZeroAtZero = 0.95;
probOfOneAtOne = 0.85;
pZeroIid = 0.95;
iterationsPerMRL = 100;
inputSize = 10^4;

% following variables will store data for plotting

% four tests are essentially being conducted here, encoding of iid source
% with iid encoder, encoding of Markov source with iid encoder and encoding
% of Markov source with Markov encoding, encoding of iid with Markov encoder
% Hopefully Markov encoder will do better in all cases

RLcompressionRatioToPlotIidIid = [];
RLcompressionRatioToPlotIidMarkov = [];
RLcompressionRatioToPlotMarkovMarkov = [];
RLcompressionRatioToPlotMarkovIid = [];

for mrl_idx = 1 : length(max_run_length)
    
    % variables for each iteration
    RLcompressionRatio1 = 0;
    RLcompressionRatio2 = 0;
    RLcompressionRatio3 = 0;
    RLcompressionRatio4 = 0;
    
    for j = 1 : iterationsPerMRL
        
        % Iid encoding on iid source
        iidInput = rand(1,inputSize) > pZeroIid;
        iidEncoded = Run_Length_Encoder(iidInput, max_run_length(mrl_idx));
        [m1,n1] = size(dec2bin(iidEncoded));
        RLcompressionRatio1 = RLcompressionRatio1 +((m1*n1)/length(iidInput));

        MarkovInput = MarkovSource(inputSize, probOfZeroAtZero, probOfOneAtOne);

        % iid encoding on Markov source
        iidEncoded = Run_Length_Encoder(MarkovInput, max_run_length(mrl_idx));
        [m2,n2] = size(dec2bin(iidEncoded));
        RLcompressionRatio2 = RLcompressionRatio2 +((m2*n2)/length(MarkovInput));
        
        % Markov encoding on iid source
        [MarkovEncoded, switchIdx] = MarkovEncoder(iidInput, max_run_length(mrl_idx), 0, 1);
        [m3,n3] = size(dec2bin(MarkovEncoded));
        RLcompressionRatio3 = RLcompressionRatio3 +((m3*n3)/length(iidInput));
        
        % Markov encoding on Markov source
        [MarkovEncoded, switchIdx] = MarkovEncoder(MarkovInput, max_run_length(mrl_idx), 0, 1);
        decoded = MarkovDecoder(MarkovEncoded, switchIdx, 0, 1, max_run_length(mrl_idx));
        
        if ((length(MarkovInput) ~= length(decoded)) | (MarkovInput ~= decoded))
            fprintf('fix me!');
        end
        
        [m4,n4] = size(dec2bin(MarkovEncoded));
        RLcompressionRatio4 = RLcompressionRatio4 +((m4*n4)/length(MarkovInput));
    end
    % average out all variables
    RLcompressionRatio1 = RLcompressionRatio1/iterationsPerMRL;
    RLcompressionRatio2 = RLcompressionRatio2/iterationsPerMRL;
    RLcompressionRatio3 = RLcompressionRatio3/iterationsPerMRL;
    RLcompressionRatio4 = RLcompressionRatio4/iterationsPerMRL;
    
    % Now store the averaged out values for plots
    RLcompressionRatioToPlotIidIid = [RLcompressionRatioToPlotIidIid RLcompressionRatio1];
    RLcompressionRatioToPlotIidMarkov = [RLcompressionRatioToPlotIidMarkov RLcompressionRatio2];
    RLcompressionRatioToPlotMarkovIid = [RLcompressionRatioToPlotMarkovIid RLcompressionRatio3];
    RLcompressionRatioToPlotMarkovMarkov = [RLcompressionRatioToPlotMarkovMarkov RLcompressionRatio4];

    
end
% Plot for Compression ratio comparison
figure
stem(max_run_length, RLcompressionRatioToPlotIidIid, 'filled', 'red');
hold on
stem(max_run_length, RLcompressionRatioToPlotIidMarkov, 'filled', 'green');
hold on
stem(max_run_length, RLcompressionRatioToPlotMarkovIid, 'blue');
hold on
stem(max_run_length, RLcompressionRatioToPlotMarkovMarkov, 'black');
grid on
legend('iid encoder with iid source', 'iid encoder with Markov source','Markov encoder with iid source', 'Markov encoder with Markov source');
xlabel('max run-length size');
ylabel('Compression ratio');
title('Run-Length comparison of iid encoder and markov encoder with iid and markov sources');
% hist(HuffmanCompSize/1000, 20);
% grid on
% title('Huffman compression efficiency');
end