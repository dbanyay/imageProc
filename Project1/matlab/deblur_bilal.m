function im_deblur = deblur_bilal(im_bl,h,noise_var,type)

% h = mat2gray(h);    %Normalize the kernel function

estimated_nsr = noise_var / var(im_bl(:))
% estimated_nsr = 0.01

fft_size1 = size(h,1) + size(im_bl,1);
fft_size2 = size(h,2) + size(im_bl,2);

H = (fft2(h , fft_size1 , fft_size2));
im_bl_fft = (fft2(im_bl , fft_size1 , fft_size2));

H_mag = H.*conj(H);
% F = (conj(H)./((abs(H)).^2 + (estimated_nsr)));
F = (conj(H)./(H_mag + (estimated_nsr)));

% im_bl = padarray(im_bl,[size(h,1)/2 size(h,2)/2], 'symmetric');
% im_bl_fft = (fft2(im_bl));
% sF = size(F)
% simfft = size(im_bl)


IM_F = im_bl_fft .* F;
im_deblur = ifft2(IM_F);

