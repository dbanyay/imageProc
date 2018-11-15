function part01()

% clear all;
% clc;
% close all;

%Loading image and drawing histogram

im = imread('lena512.bmp');
figure(1)
suptitle('Histograms')
subplot(2,2,1)
imhist(im)
title('Original Image','fontweight','normal');

%Reducing the contrast of Image

a = 0.2;
b = 50;

imRedDynRange = round(a*im + b);
imRedDynRange(imRedDynRange > 255) = 255;
imRedDynRange(imRedDynRange < 000) = 000;

figure(1)
subplot(2,2,2)
imhist(imRedDynRange)
title('Reduced Contrast Image','fontweight','normal');

figure(2)
suptitle('Grayscale Representation')
subplot(2,2,1)
imshow(im)
title('Original Image','fontweight','normal');
subplot(2,2,2)
imshow(imRedDynRange)
title('After Contrast Reduction','fontweight','normal');

figure(3)
suptitle('Scaled Colors Representation')
subplot(2,2,1)
imagesc(im, [0 255]);
colorbar;
title('Original Image','fontweight','normal');
subplot(2,2,2)
imagesc(imRedDynRange, [0 255]);
colorbar;
title('After Contrast Reduction','fontweight','normal');

%Histogram Equalization
[counts,binLocations] = imhist(im);
probaBin = 255*counts./(sum(counts));
equalizedValue = cumsum(probaBin);
eqIm = im;

for i = 1:numel(binLocations)
    eqIm(im == binLocations(i)) = equalizedValue(i);
end

figure(1)
subplot(2,2,3)
imhist(eqIm)
title('After Histogram Equalization','fontweight','normal');

figure(2)
subplot(2,2,3)
imshow(eqIm);
title('After Histogram Equalization','fontweight','normal');

figure(3)
subplot(2,2,3)
imagesc(eqIm, [0 255]);
colorbar;
title('After Histogram Equalization','fontweight','normal');

figure(4)
title('Transfer function used for Equalization')
% subplot(2,1,1)
stem(binLocations,equalizedValue)
axis([0 255 0 255])

% [J,T] = histeq(im); %returns the grayscale transformation T that maps gray levels in the image I to gray levels in J.
% subplot(2,1,2)
% stem(T)
end