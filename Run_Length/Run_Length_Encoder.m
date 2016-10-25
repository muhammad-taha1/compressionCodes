%% Run-Length Encoder
% Try 3, 7, 15, 31 codes, insert one at the end of the code,  
% Convert into ASCII code the nfedd it into huffmaan. 

function IntermediateSymbol  = Run_Length_Encoder(InputData)
 
    tempOutput = []; 
    count =1; 

    prev = InputData(1); 
 % If length is one then it returns just 1 + string value, 
 % otherwise loop over the InputData string 
    
    if(length(InputData) == 1)
        tempOutput = [tempOutput; strcat(num2str(count), prev)];
    else
 %  Check if current is equal to previous at indices n and n-1 of InputData
 %  If equal increment the count and index of current 
 %  If not, add count and InputData(n) char to output, and reset count to 1. 
 
        for n = 2: length(InputData)           
            current = InputData(n);
            if (current == prev) 
                count = count + 1; 
            else
                tempOutput = [tempOutput; strcat(num2str(count), prev)]; 
                count = 1; 
            end
            prev = current; 

        end

        tempOutput = [tempOutput; strcat(num2str(count), prev)];
    end
    IntermediateSymbol = tempOutput;

end 