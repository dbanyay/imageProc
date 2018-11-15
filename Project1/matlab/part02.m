function part02()

%Loading Image
im = imread('lena512.bmp');

%Contaminating image with gaussian noise
n = round(mynoisegen('gaussian', 512, 512, 0, 64));
im_gauss = double(im) + n;
im_gauss(im_gauss > 255) = 255;
im_gauss(im_gauss < 000) = 000;
im_gauss = uint8(im_gauss);

%Contaminating image with salt and pepper noise
im_saltp = im;
n = mynoisegen('saltpepper', 512, 512, .05, .05);
im_saltp(n==0) = 0;
im_saltp(n==1) = 255;

%Mean Filtering
mean_filter = (1/9)*ones(3,3);
meanFil_gauss = uint8(conv2(mean_filter,im_gauss));
meanFil_saltp = uint8(conv2(mean_filter,im_saltp));

figure(1)
subplot(3,2,1)
imhist(im);
subplot(3,2,2)
imhist(im);
subplot(3,2,3)
imhist(im_gauss);
subplot(3,2,5)
imhist(im_saltp);
subplot(3,2,4)
imhist(meanFil_gauss);
subplot(3,2,6)
imhist(meanFil_saltp);

%Median Filtering
medFil_gauss = uint8(medfilt2(im_gauss));
medFil_saltp = uint8(medfilt2(im_saltp));
figure(2)
subplot(3,2,1)
imhist(im);
subplot(3,2,2)
imhist(im);
subplot(3,2,3)
imhist(im_gauss);
subplot(3,2,5)
imhist(im_saltp);
subplot(3,2,4)
imhist(medFil_gauss);
subplot(3,2,6)
imhist(medFil_saltp);

figure(3)
subplot(3,3,[1,2,3])
imshow(im)
subplot(3,3,4)
imshow(im_gauss)
subplot(3,3,5)
imshow(meanFil_gauss)
subplot(3,3,6)
imshow(medFil_gauss)

subplot(3,3,7)
imshow(im_saltp)
subplot(3,3,8)
imshow(meanFil_saltp)
subplot(3,3,9)
imshow(medFil_saltp)



end