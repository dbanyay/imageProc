function im_deblur = deblur(im_bl,h,var)

G=fftshift(fft2(im_bl,size(im_bl,1),size(im_bl,2)));
H=fftshift(fft2(h,size(im_bl,1),size(im_bl,2)));

F=G.*H./(H.^2+(var));

F=ifftshift(F);

im_deblur=uint8(abs(ifft2(F)));   


end