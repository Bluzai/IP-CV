function [ out ] = iHT( img )
%IHT Summary of this function goes here
%   Detailed explanation goes here
    [R,C] = size(img);
    img = double(img);
    HA = zeros(R,C);
    N = C;
    HA(1,:) = 1/sqrt(N);
    i = 1;
    % produce Haar matrix
    for r = 0 : log2(N)-1
        for m = 1 : 2^r
            i = i+1;
            for x = 0 : N-1
                if x >= N*(m-1)/(2^r) && x < N*(m-1/2)/(2^r)
                    HA(i,x+1) = 2^(r/2)/sqrt(N);
                end
                if x >= N*(m-1/2)/(2^r) && x < N*m/(2^r)
                    HA(i,x+1) = -2^(r/2)/sqrt(N);
                end
            end
        end
    end
    out = HA * img * HA';
    figure,imshow(uint8(out));
end