function probVector = computeMarkovProb(symbolsSize, probZeroAtZero, probOneAtOne)
probInterVector = []; 

clc 

for n = 1: (symbolsSize +1)
    if (n == 1) 
        probInterVector = [probInterVector, probOneAtOne];
    elseif (n == (symbolsSize + 1))
        probInterVector = [probInterVector, (1 - probOneAtOne)*(probZeroAtZero^(n-2))];
    else
        probInterVector = [probInterVector, (1 - probZeroAtZero)*(1 - probOneAtOne)*(probZeroAtZero)^(n-2)];

    end
end
    probVector =probInterVector; 
end  