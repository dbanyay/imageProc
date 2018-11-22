close all
clear all

%% 1. Open image

im = imread('lena512.bmp');

%% Create salt-pepper noisy image 

im_sp = im; 
n = mynoisegen('saltpepper', 512, 512, .05, .05);
im_sp(n==0) = 0;
im_sp(n==1) = 255;



%% 2. Spatial filtering

%Reducing the contrast of Image

a = 0.2;
b = 50;

imRedDynRange = round(a*im + b);
imRedDynRange(imRedDynRange > 255) = 255;
imRedDynRange(imRedDynRange < 000) = 000;

%Histogram Equalization
[counts,binLocations] = imhist(im);
probaBin = 255*counts./(sum(counts));
equalizedValue = cumsum(probaBin);
eqIm = im;

for i = 1:numel(binLocations)
    eqIm(im == binLocations(i)) = equalizedValue(i);
end

% %Plotting the Histograms
% figure(1)
% subplot(3,1,1)
% imhist(im)
% title('Original Image','fontweight','normal');
% % bar('BarWidth', 0);
% subplot(3,1,2)
% imhist(imRedDynRange)
% title('Reduced Contrast Image','fontweight','normal');
% ylabel('h(r)')
% subplot(3,1,3)
% imhist(eqIm)
% title('After Histogram Equalization','fontweight','normal');
% xlabel('r')
% 
% %Plotting the transfer function used for histogram equalization
% figure()
% stem(binLocations,equalizedValue)
% axis([0 255 0 255])
% xlabel('Gray Scale value in original Image')
% ylabel('Gray Scale value in transformed Image')
% title('Transfer function used for Equalization')
% % 
% % %Grayscale representation of Images
% % figure(2)
% % suptitle('Grayscale Representation')
% % subplot(2,2,1)
% % imshow(im)
% % title('Original Image','fontweight','normal');
% % subplot(2,2,2)
% % imshow(imRedDynRange)
% % title('After Contrast Reduction','fontweight','normal');
% % subplot(2,2,3)
% % imshow(eqIm);
% % title('After Histogram Equalization','fontweight','normal');
% 
%Scale color representation of Images for Visual Inspection
% figure(3)
% subplot(2,2,1)
% imagesc(im, [0 255]);
% colorbar;
% title('Original Image','fontweight','normal');
% subplot(2,2,2)
% imagesc(imRedDynRange, [0 255]);
% colorbar;
% title('After Contrast Reduction','fontweight','normal');
% subplot(2,2,3)
% imagesc(eqIm, [0 255]);
% colorbar;
% title('After Histogram Equalization','fontweight','normal');
% 
% part02(im, im_sp);
% 
%% 3. Freqency domain filtering

im_bl = imread('boats512_outoffocus.bmp');

h = myblurgen('gaussian',8);

noise_var = 0.0833;

im_deblur = deblur(im_bl,h,noise_var);

figure
subplot(2,2,2)
imshow(im_deblur)
title('Original image')

subplot(2,2,1)
imshow(im_bl)
title('Blurred image')

subplot(2,2,3)
imagesc(log(abs(fftshift(fft2(im_bl)))));
title('Spectrum of blurred image')
colorbar
caxis([0 16])

subplot(2,2,4)
imagesc(log(abs(fftshift(fft2(im_deblur)))))
title('Spectrum of deblurred image')
colorbar
caxis([0 16])