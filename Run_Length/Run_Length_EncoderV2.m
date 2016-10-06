function [Compr_Strng] = Run_Length_EncoderV2(Sourcedata)

%initiate
%Matrix with all the code words to be used for compression
% the row number is equal to the number of 0's preceding a 1, that each code word
% will represent
CodeBook = [0 0 0; 0 1;0 1 0;0 1 1;1 0 0;1 0 1;1 1 0;1 1 1];
%array for compressed string
Compr_Strng = [];
%i is the variable used for the condition of the while loop
  i=1;
  %since the compression is based on the run of 0's and the largest run that is
  %compressed will have seven 0's therefore the while loop will iterate until
  %it comes across a 1; the max run being seven 0's 
    while i<=7
        
        if Sourcedata(i) == 1 
 % as soon as there's a 1, the run of pixels/bits is comressed with the
 % appropriate code word from the code book matrix 
            Compr_Strng = [Compr_Strng,CodeBook(i,1:3)];
%the part of the source file that has been compressed is deleted from the
%array storing the values and the loop is reseat to repeat the process
            Sourcedata = Sourcedata(i+1:end);
            i=0;
        end
        
        if i==7 && Sourcedata(i)==0
   %if there's no 1 for a run of 7 consecutive bits, compression needs to
   %be done with a seperate statement so that the loop can be reset if the
   %entire source data file has not been compressed yet.
            Compr_Strng = [Compr_Strng,CodeBook(8,1:3)];
            Sourcedata = Sourcedata(i+1:end); 
            i=0;
        end
   %as soon as the entire source data file has been compressed, the while loop is
   %ended with a break statement
        if length(Sourcedata) ==0
            break
       end
       
        i=i+1;
    end
    
    

    
end 
    
   
