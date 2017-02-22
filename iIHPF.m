function [ out ] = iIHPF( img, d0 )
%IIHPF Summary of this function goes here
%   Detailed explanation goes here
    tic; %Time start
    [m,n]=size(img);
    %d0 = input('Please input the cut-off frequency: ');
    h = zeros(size(img));
    for u = 0 : m-1
        for v = 0 : n-1
            if (u - m/2-1/2)^2 + (v - n/2-1/2)^2 > d0^2
                h(u+1,v+1) = 1;
            end
        end
    end
    out = iFFT_2D(img) .* h;
    out = uint8(iIFFT(out));
    % Display total time
    disp(['Total time used in terms of cut-off frequency [',num2str(d0),'] is ',num2str(toc),' secs.']);
    figure,imshow(out);
end

