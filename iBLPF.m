function [ out ] = iBLPF( img, d0, n0 )
%IBLPF Summary of this function goes here
%   Detailed explanation goes here
    tic; %Time start
    [m,n]=size(img);
    %d0 = input('Please input the cut-off frequency: ');
    %n0 = input('Please input the order: ');
    h = zeros(size(img));
    for u = 0 : m-1
        for v = 0 : n-1
            h(u+1,v+1) = 1/(1+(sqrt((u-m/2-1/2)^2 + (v-n/2-1/2)^2)/d0)^(2*n0));
        end
    end
    out = iFFT_2D(img) .* h;
    out = uint8(iIFFT(out));
    % Display total time
    disp(['Total time used in terms of cut-off frequency [',num2str(d0),'] and order [',num2str(n0),'] is ',num2str(toc),' secs.']);
    figure,imshow(out);
end