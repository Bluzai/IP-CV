function [ out ] = iSOB( img )
%ISOB Summary of this function goes here
%   Detailed explanation goes here
    [m,n] = size(img);
    %first gradient
    out1 = zeros([m,n]);
    %second gradient
    out2 = zeros([m,n]);
    %fist row unchanged
    out1(1,:) = img(1,:);
    out2(1,:) = img(1,:);
    %last row unchanged
    out1(m,:) = img(m,:);
    out2(m,:) = img(m,:);
    %fist column unchanged
    out1(:,1) = img(:,1);
    out2(:,1) = img(:,1);
    %last column unchanged
    out1(:,n) = img(:,n);
    out2(:,n) = img(:,n);
    for x = 2 : m-1
        for y = 2 : n-1
            out1(x,y) = ((img(x-1,y+1) + 2*img(x,y+1) + img(x+1,y+1)) - (img(x-1,y-1) + 2*img(x,y-1) + img(x+1,y-1)))/4;
            out2(x,y) = ((img(x-1,y-1) + 2*img(x-1,y) + img(x-1,y+1)) - (img(x+1,y-1) + 2*img(x+1,y) + img(x+1,y+1)))/4;
        end
    end
    %the final gradient
    out = round(sqrt(out1 .* out1 + out2 .* out2));
    out = uint8(out);
    figure,imshow(out);
end