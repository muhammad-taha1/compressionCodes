function MarkovTest()

input = MarkovSource(20, 0.85, 0.7);
mrl = 7;

[encoded, switchIdx] = MarkovEncoder(input, mrl, 0, 1);
decoded = MarkovDecoder(encoded, switchIdx, 0, 1, mrl, input);

if (input ~= decoded)
    fprintf('fix me!');
end
end