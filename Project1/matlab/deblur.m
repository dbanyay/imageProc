function im_deblur = deblur(im_bl_fft,Sf,Sn,h,type)

H = fft2(h,size(Sf,1),size(Sf,2));

if type == 'MMSE' % Wiener filter
    
    H_conj = conj(H); % if H is real valued it does nothing
    
    H_mag = H*H_conj;
    
    K = abs(Sn^2)./abs(Sf^2);     
    
    deblur_filt = (1./H).*(H_mag./(H_mag+K));  
    
    im_deblur = ifft2(fftshift(deblur_filt.*im_bl_fft));
    
     
   
elseif type == 'CLS'
    

else
    warning('wrong filter type')
end

end
