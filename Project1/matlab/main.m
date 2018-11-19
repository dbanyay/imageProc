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

<<<<<<< HEAD
=======

>>>>>>> 554fe3b751add174759c2357dc329c3a93fb1865
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

<<<<<<< HEAD
% var = im_fft-im_bl_fft; % calculate noise variance
var = 0.0833;

im_deblur = deblur(im_bl,var,h,'MMSE',im); %'MMSE' for Minimum Mean Square Error, 
=======
%% Deblur algorithm

var = 0.0833;


im_deblur = deblur(im_bl,h,var,'MMSE'); %'MMSE' for Minimum Mean Square Error, 
>>>>>>> 554fe3b751add174759c2357dc329c3a93fb1865
                                              % 'CLS' for Constrained Least Square

figure;
subplot(122)
imshow(im_deblur,[])
title('Deblurred')

subplot(121)
imshow(im_bl,[])
title('Blurred')

