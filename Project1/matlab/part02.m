function part02(im, im_saltp)

%Contaminating image with gaussian noise
n = round(mynoisegen('gaussian', 512, 512, 0, 64));
im_gauss = double(im) + n;
im_gauss(im_gauss > 255) = 255;
im_gauss(im_gauss < 000) = 000;
im_gauss = uint8(im_gauss);

%Mean Filtering
mean_filter = (1/9)*ones(3,3);
meanFil_gauss = uint8(conv2(mean_filter,im_gauss));
meanFil_saltp = uint8(conv2(mean_filter,im_saltp));

%Median Filtering
medFil_gauss = uint8(medfilt2(im_gauss));
medFil_saltp = uint8(medfilt2(im_saltp));

%Plotting the histograms for comparison
figure()
subplot(3,3,1)
imhist(im);
title('Original Image')
subplot(3,3,2)
imhist(im_gauss);
title('Image with Gaussian Noise')
subplot(3,3,3)
imhist(im_saltp);
title('Image with Salt & Pepper Noise')
subplot(3,3,5)
imhist(meanFil_gauss);
title('After Mean Filtering Gaussian Noise')
subplot(3,3,6)
imhist(meanFil_saltp);
title('After Mean Filtering Salt & Pepper Noise')
subplot(3,3,8)
imhist(medFil_gauss);
title('After Median Filtering Gaussian Noise')
subplot(3,3,9)
imhist(medFil_saltp);
title('After Median Filtering Salt & Pepper Noise')

%Grayscale Representation of Images
% figure()
% subplot(2,2,1)
% imshow(im)
% title('Original Image')
% subplot(2,2,2)
% imshow(im_gauss)
% title('Image with Gaussian Noise')
% subplot(2,2,3)
% imshow(meanFil_gauss)
% title('After Mean Filtering Gaussian Noise')
% subplot(2,2,4)
% imshow(medFil_gauss)
% title('After Median Filtering Gaussian Noise')

figure()
subplot(2,2,1)
imshow(im)
title('Original Image')
subplot(2,2,2)
imshow(im_saltp)
title('Image with Salt & Pepper Noise')
subplot(2,2,3)
imshow(meanFil_saltp)
title('After Mean Filtering Salt & Pepper Noise')
subplot(2,2,4)
imshow(medFil_saltp)
title('After Median Filtering Salt & Pepper Noise')
% 
end