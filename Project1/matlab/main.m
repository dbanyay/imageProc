close all
clear all

%% 1. Open image

im = imread('lena512.bmp');

%% Create salt-pepper noisy image 

im_sp = im; 
n = mynoisegen('saltpepper', 512, 512, .05, .05);
im_sp(n==0) = 0;
im_sp(n==1) = 255;

%imshow(im_sp)

%% Create blurry image

r = 8; % radius of Gaussian kernel

h = myblurgen('gaussian',r);

im_bl = conv2(im,h,'same');

%imshow(uint8(im_bl))

%% 2. Spatial filtering


%% 3. Freqency domain filtering

im_fft = fft2(im);
im_bl_fft = fft2(im_bl);

subplot(2,2,1)
imshow(im)
title('Original image')

subplot(2,2,2)
imshow(uint8(im_bl))
title('Blurred image')

subplot(2,2,3)
imagesc(abs(fftshift(im_fft)),[0 255])
title('Spectrum of original image')
colorbar

subplot(2,2,4)
imagesc(abs(fftshift(im_bl_fft)),[0 255])
title('Spectrum of blurred image')
colorbar


var = im_fft-im_bl_fft; % calculate noise variance

im_deblur = deblur(im_bl_fft,im_fft,var,h,'MMSE'); %'MMSE' for Minimum Mean Square Error, 
                                              % 'CLS' for Constrained Least Square

figure;

imshow((im_deblur),[])
