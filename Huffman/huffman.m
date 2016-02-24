function codebook = huffman(p, codebookIn)
%codebook = [0 1];
if length(p) == 2
    codebook = codebookIn;
    l = [1 1];
else
    q = [p(1: end - 2), p(end - 1)+p(end)];
    q = sort(q, 'descend');
    
  
    a = [codebookIn(1: end - 1, :)]
    b = [codebookIn(end), 0]
    c = [codebookIn(end), 1]
    
    codebook = [a,
         b,
         c];
   % l = [l(1:end - 1)];
    codebook = huffman(q, codebook);
    
end
    
    
