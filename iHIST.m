function [ out, h0, ha ] = iHIST( img )
%IHIST Summary of this function goes here
%   Detailed explanation goes here
    [m,n]=size(img);
    l = 256;
    n0 = zeros(1,l);
    % the Histogram of original image
    for x = 1 : m
        for y = 1 : n
            n0(img(x,y)+1) = n0(img(x,y)+1) + 1;
        end
    end
    n0 = n0 ./ (m*n);
    % Equalized Histogram
    s = zeros(1,l);
    s(1) = n0(1);
    for j = 2 : l
        s(j) = s(j-1) + n0(j);
    end
    s(:) = round(s(:) * (l-1));
    levels = 1;
    s1(1) = 1;
    for j = 2 : l
        if(s(j) ~= s(j-1))
            levels = levels + 1;
            s1(levels) = j;
        end
    end
    n1 = zeros(1,levels);
    for i = 1 : levels-1
        for j = s1(i) : s1(i+1)-1
            n1(i) = n1(i) + n0(j);
        end
    end
    n1(levels) = 1 - sum(n1(1 : levels-1));
    na = zeros(1,l);
    for i = 1 : levels
        na(s(s1(i))+1) = n1(i);
    end
    % Image Enhancement
    out = zeros(m,n);
    for x = 1 : m
        for y = 1 : n
            i = img(x,y);
            out(x,y) = s(i+1);
        end
    end
    out = uint8(out);
    % Original histogram
    h0 = n0;
    % Enhanced histogram
    ha = na;
    figure,imshow(out);
end