function im = deblur(im_bl,h,var,type)

h = mat2gray(h); %normalize [0,1]
h = imresize(h,size(im_bl));

G = fftshift(fft2(im_bl));


if type == 'MMSE' % Wiener filter
    
    F = (h./(h.^2+(var))); 
    
    IM_F = G.*F;
    
    im = ifft2(ifftshift(IM_F));   
    
   
elseif type == 'CLS'
    

else
    warning('wrong filter type')
end

end
