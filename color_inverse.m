% Take an input image f (x, y) and find its negative 
% by using the expression |f (x, y)-255| or 255 – f (x, y) 
% as an exercise to read and write an image and manipulate its pixels.

f0 = imread ('IM0.JPG');
f1 = imread ('IM1.JPG');
f0_imcomplement_1 = 255 - f0;
f0_imcomplement_2 = imcomplement (f0);
f1_imcomplement_1 = 255 - f1;
f1_imcomplement_2 = imcomplement (f1);
imwrite (f0_imcomplement_1,'f0_imcomplement_1','tif');
imwrite (f0_imcomplement_2,'f0_imcomplement_2','tif');
imwrite (f1_imcomplement_1,'f1_imcomplement_1','tif');
imwrite (f1_imcomplement_2,'f1_imcomplement_2','tif');
