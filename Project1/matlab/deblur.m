function im_deblur = deblur(im_bl,h,n_var)


bl_var = var(double(im_bl(:)));


r_pad = size(h,1)-1;
c_pad = size(h,2)-1;

im_bl= padarray(im_bl,[r_pad c_pad],0,'both');

G=fftshift(fft2(im_bl));
H=fftshift(fft2(h,size(im_bl,1),size(im_bl,2)));

K = n_var/(bl_var-n_var);
F=G.*H./(H.^2+(K));

F=ifftshift(F);

im_deblur=abs(ifft2(F));   
imshow(uint8(im_deblur));

end