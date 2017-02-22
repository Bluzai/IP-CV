function [ out ] = iJPEG( img )
%IJPEG Summary of this function goes here
%   Detailed explanation goes here
    [m,n] = size(img);
    % Quantization matrix 8*8
    Q = [16,11,10,16,24,40,51,61;
        12,12,14,19,26,58,60,55;
        14,13,16,24,40,57,69,56;
        14,17,22,29,51,87,80,62;
        18,22,37,56,68,109,103,77;
        24,35,55,64,81,104,113,92;
        49,64,78,87,103,121,120,101;
        72,92,95,98,112,100,103,99
        ];
    % 8*8 DCT Block Number
    nb = n/8;
    out = zeros(m,n);
    % original image size for storage
    sizeo = 0;
    % compressed image size for storage
    sizec = 0;
    for i = 0 : nb-1
        for j = 0 : nb-1
            % define the 8*8 subimage
            simg = img((1+i*8):8*(i+1),(1+j*8):8*(j+1));
            % DCT of the subimage
            d1 = iDCT1(simg);
            d2 = iDCT2(simg);
            sizeo = sizeo + length(find((d1+d2)/2));
            % compressed image data
            d1 = round(d1./Q);
            d2 = round(d2./Q);
            sizec = sizec + length(find((d1+d2)/2));
            d1 = Q .* d1;
            d2 = Q .* d2;
            % IDCT of the quantizer subimage
            out((1+i*8):8*(i+1),(1+j*8):8*(j+1)) = iIDCT2(d1,d2);
        end
    end
    out = uint8(out);
    % the compression ratio
    r = sizec/sizeo;
    disp(['The compression ratio is ',num2str(r),'. ']);
    figure,imshow(out);
end

