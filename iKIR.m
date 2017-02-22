function [ out ] = iKIR( img )
%IKIR Summary of this function goes here
%   Detailed explanation goes here
    [m,n] = size(img);
    % Output Image
    out = zeros([m,n]);
    % let A store the 8 neighbors of the points being operated
    A = zeros([1,8]);
    % let K store the 8 values of |5*S(i)-3*T(i)|
    K = zeros([1,8]);
    % fist row unchanged
    out(1,:) = img(1,:);
    % last row unchanged
    out(m,:) = img(m,:);
    % fist column unchanged
    out(:,1) = img(:,1);
    % last column unchanged
    out(:,n) = img(:,n);
    for x = 2:m-1
        for y = 2:n-1
            A(1) = img(x-1,y-1);
            A(2) = img(x-1,y);
            A(3) = img(x-1,y+1);
            A(4) = img(x,y+1);
            A(5) = img(x+1,y+1);
            A(6) = img(x+1,y);
            A(7) = img(x+1,y-1);
            A(8) = img(x,y-1);
                % calculate the values using the Kirsh Operator
                for i = 1 : 8
                    S = A(i)+A(mod(i+1,8)+1)+A(mod(i+2,8)+1);
                    T = A(mod(i+3,8)+1) + A(mod(i+4,8)+1) + A(mod(i+5,8)+1) +A(mod(i+6,8)+1) + A(mod(i+7,8)+1);
                    K(i) = abs(5*S-3*T);
                end
            out(x,y) = max(K);
        end
    end
    %1/15 is the scale factor
    out = out./15;
    out = uint8(out);
    figure,imshow(out);
end