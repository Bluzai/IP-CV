function [ out ] = DFT ( img )
%DFT Summary of this function goes here
%   Detailed explanation goes here
    tic;%Time starts
    [m,n] = size(img);
    img = double(img);
    % Center Fourier
    for x = 0 : m-1
        for y = 0 : n-1
            img(x+1,y+1) = ((-1)^(x+y))*img(x+1,y+1);
        end
    end
    % Fourier
    out_tmp = zeros([m,n]);
    for u = 0 : m-1
        for v = 0 : n-1
            for x = 0 : m-1
                for y = 0 : n-1
                    out_tmp(u+1,v+1) = out_tmp(u+1,v+1) + img(x+1,y+1)*exp(-2*1i*pi*(u*x/m+v*y/n));
                end
            end
            out_tmp(u+1,v+1) = out_tmp(u+1,v+1)/(m*n);
        end
    end
    out = zeros(size(out_tmp));
    % Calculate Fourier Spectrum
    spe = abs(out_tmp);
    % Use the following formula to make the frequency terms visualised
    maxF = max(max(spe));
    for u = 1 : m
        for v = 1 : n
            out(u,v) = 255 * log10(1 + 255 * spe(u,v)/maxF)/log10(256);
            out(u,v) = round(out(u,v));
        end
    end
    out = uint8(out);
    % Display total time
    disp(['Total time used in terms of size [',num2str(m),'*',num2str(n),'] is ',num2str(toc),' secs.']);
    figure,imshow(out);
end

