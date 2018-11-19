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


%% 2. Spatial filtering


%% 3. Freqency domain filtering


im_fft = abs(fftshift(fft2(im))).^2;
im_bl_fft = abs(fftshift(fft2(im_bl))).^2;

subplot(2,2,1)
imshow(im)
title('Original image')

subplot(2,2,2)
imshow(im_bl)
title('Blurred image')

subplot(2,2,3)
imagesc(log(im_fft))
title('Spectrum of original image')
colorbar

subplot(2,2,4)
imagesc(log(im_bl_fft))
title('Spectrum of blurred image')
colorbar

%% Deblur algorithm

var = 0.0833;


im_deblur = deblur(im_bl,h,var,'MMSE'); %'MMSE' for Minimum Mean Square Error, 
                                              % 'CLS' for Constrained Least Square

figure;
subplot(122)
imshow(im_deblur,[])
title('Deblurred')

subplot(121)
imshow(im_bl,[])
title('Blurred')

