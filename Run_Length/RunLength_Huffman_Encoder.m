function [Compr_Strng] = RunLength_Huffman_Encoder(Sourcedata)

 Compr_Strng = [];
p = [0.05,0.95*0.05,0.95^2*0.05,0.95^3*0.05,0.95^4*0.05,0.95^5*0.05,0.95^6*0.05,0.95^7];

p=sort(p,'descend');
[l,CB] = Huffman(p);

 i=1;
    while i<=7
        
        if Sourcedata(i) == 1 
            
           Compr_Strng = [Compr_Strng,CB(i+1,1:l(i+1))];
           Sourcedata = Sourcedata(i+1:end);
           i=0;
        end
        
        if i==7 && Sourcedata(i)==0
           
          Compr_Strng = [Compr_Strng,CB(1,1)];
          Sourcedata = Sourcedata(i+1:end); 
          i=0;
       end
        
        if length(Sourcedata) ==0
          
          break
       end
        
       i=i+1;
    end
    


end