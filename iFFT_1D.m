function [ out ] = iFFT_1D( img )
%IFFT_1D Summary of this function goes here
%   Detailed explanation goes here
    n0 = length(img);
    % Recognise if img length is power of 2 or not  
    if mod(n0,2) == 1
        n = n0+1;
    else
        n = n0;
    end
    if log2(n) ~= fix(log2(n))
        n = 2^(fix(log2(n))+1);
    end
    temp = zeros(1,n);
    for t = 1 : n0
        temp(t) = img(t);
    end
    img = temp;
    % Bit reversal start
    p = 0 : n-1; 
    nb = log2(n);
    p1 = p;
    b = zeros(1,n);
    for t = 1 : nb
        b = b*2 + mod(p1,2);
        p1 = floor(p1/2);
    end
    temp(p+1) = img(b+1);
    img = temp;
    % Bit reversal end
    % Calculate w(from w(0) to w(n/2-1)) start
    t = 0 : n/2-1;
    w = exp(-2*1i*pi*t/n);
    % Calculate end
    temp = zeros(size(img));
    % Calculate Fourier start
    for s = 1 : nb
        m = 2^(s-1);
        for b = 1 : 2^(nb-s)
            k = 2*(b-1)*m + 1;
            for t = 1 : m
                % Determine the power of w
                pw = mod((k-1) * 2^(nb-s), 2^nb) + 1;
                temp(k) = img(k)/2 + w(pw)*img(k+m)/2;
                temp(k+m) = img(k)/2 - w(pw)*img(k+m)/2;
                k = k+1;
            end
        end
        img = temp;
    end
    % Calculate end
    out = img;
end

