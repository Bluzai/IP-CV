function [ out ] = iLAoGAU( img,d0 )
%ILAOGAU Summary of this function goes here
%   Detailed explanation goes here
    tic; %Time start
    [m,n]=size(img);
    img = double(img);
    %d0 = input('Please input the cut-off frequency: ');
    h = zeros(size(img));
    d_h = zeros(size(img));
    % Gaussian point spread function
    for u = 0 : m-1
        for v = 0 : n-1
            h(u+1,v+1) = exp(-((u-m/2-1/2)^2+(v-n/2-1/2)^2)*d0^2/2);
        end
    end
    out1 = iFFT_2D(img) .* h;
    % Laplacian of a Ganssian
    for u = 0 : m-1
        for v = 0 : n-1
            d_h(u+1,v+1) = -((u-m/2-1/2)^2 + (v-n/2-1/2)^2);
        end
    end
    out2 = out1 .* d_h;
    out = uint8(iIFFT(out2));
    % Display total time
    disp(['Total time used in terms of standard deviation [',num2str(d0),'] is ',num2str(toc),' secs.']);
    figure,imshow(out);
end