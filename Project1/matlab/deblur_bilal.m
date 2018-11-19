function im_deblur = deblur_bilal(im_bl,noise_var,h,type,im)

estimated_nsr = noise_var / var(im_bl(:));

fft_size1 = size(h,1) + size(im_bl,1) + 1;
fft_size2 = size(h,2) + size(im_bl,2) + 1;

H = fft2(h , fft_size1 , fft_size2);
im_bl_fft = fft2(im_bl , fft_size1 , fft_size2);

