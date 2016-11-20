%% Create Raw Image 
% 256 by 256 pixels binary image that has a sqaure 90 by 90 pixels square
% on left

rawImg = [];  
for i= 1: 256 
    for j=1: 256 
        if (((i == 10) || (i == 100)) && ((j>=10) && (j<=100))) 
            rawImg(i,j) = 0; 
        elseif ( ((j == 10) || (j == 100)) && ((i>=10) && (i<=100)))
            rawImg(i,j) = 0;
        else 
            rawImg(i,j) = 1; 
        end
    end
end

imshow(rawImg);