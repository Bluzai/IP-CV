% To reduce the image size in an iterative fashion using pixel averaging 
% such that if for each iteration the NxN input image is reduced in size to an N/2 x N/2 image. 
% Hint every four neighboring pixels are averaged to a single pixel output.
function [ out ] = halfReduce ( img )
%halfReduce Summary of this function goes here
%Detailed explanation goes here
    %reduce the image size - half
    [m,n] = size(img);
    if(mod(m,2) == 1)
        m = m-1;
    end
    if(mod(n,2) == 1)
        n = n-1;
    end
    out = zeros([m/2,n/2]);
    %Average the values of 4 pixels into one pixel to half-reduce the input image
    for i = 1 : m/2
        for j = 1 : n/2 
            out(i,j) = (double(img(2*i-1,2*j-1)) + double(img(2*i-1,2*j)) + double(img(2*i,2*j-1)) + double(img(2*i,2*j)))/4;
        end
    end
    out = round(out);
    out = uint8(out);
end

