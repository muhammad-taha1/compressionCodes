function [Compr_Strng] = Run_Length_EncoderV2(Sourcedata)

%initiate
CodeBook = [0 0 0;0,0,1;0 1 0;0 1 1;1 0 0;1 0 1;1 1 0;1 1 1];

Compr_Strng = [];
% Sourcedata = [0 0 0 1 0 0 1 0 0 1 0 1 0 1];
  i=1;
    while i<=7
        
        if Sourcedata(i) == 1 
            
            Compr_Strng = [Compr_Strng,CodeBook(i,1:3)];
            Sourcedata = Sourcedata(i+1:end);
            i=0;
        end
        
        if i==7 && Sourcedata(i)==0
           
            Compr_Strng = [Compr_Strng,CodeBook(8,1:3)];
            Sourcedata = Sourcedata(i+1:end); 
            i=0;
        end
        
        if length(Sourcedata) ==0
          
            break
       end
        
        i=i+1;
    end
    
    

    
end 
    
   



                         
