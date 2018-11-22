close all
clear all

%% 1. Open image

im = imread('lena512.bmp');

%% Create salt-pepper noisy image 

im_sp = im; 
n = mynoisegen('saltpepper', 512, 512, .05, .05);
im_sp(n==0) = 0;
im_sp(n==1) = 255;

%% Create blurry image

r = 8; % radius of Gaussian kernel

h = myblurgen('gaussian',r);

im_bl = conv2(im,h,'same');
% im_bl = min(max(round(im_bl), 0), 255);


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
% %% 3. Freqency domain filtering
% 
% im_fft = abs(fftshift(fft2(im))).^2;
% im_bl_fft = abs(fftshift(fft2(im_bl))).^2;
% 
% % figure()
% % subplot(2,2,1)
% % imshow(im)
% % title('Original image')
% % 
% % subplot(2,2,2)
% % imshow(im_bl,[])
% % title('Blurred image')
% % 
% % subplot(2,2,3)
% % imagesc(log(im_fft))
% % title('Spectrum of original image')
% % colorbar
% % 
% % subplot(2,2,4)
% % imagesc(log(im_bl_fft))
% % title('Spectrum of blurred image')
% % colorbar
% 
% %% Deblur algorithm
% 
% var = 0.0833;
% size(im_bl)
% im_deblur = deblur_bilal(im_bl,h,var,'MMSE'); %'MMSE' for Minimum Mean Square Error,                                               
% size(im_deblur)
% % 'CLS' for Constrained Least Square
% 
% figure;
% subplot(122)
% imshow(im_deblur,[])
% title('Deblurred')
% 
% subplot(121)
% imshow(im_bl,[])
% title('Blurred')

