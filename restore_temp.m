function img_out = restore_temp(img_in)
[r,c,ch] = size(img_in);

rng default;

% figure;imshow((psf_abs),[]);
% figure;imshow(fftshift(psf_abs),[]);
% surf([-c/2+1:c/2]/(c/2),[-r/2+1:r/2]/(r/2),fftshift(psf_abs))
% shading interp, camlight, colormap jet
% xlabel('PSF FFT magnitude')

PSF = fspecial('gaussian',7,10);
INITPSF = ones(size(PSF));
[img_out, P] = deconvblind(img_in,INITPSF);


end

function psf_turb = give_turb_psf(r,c,k1,bx,by)
psf_turb = zeros([r,c]);
for y=1:r
    for x=1:c
        if(y <= round(r/2))
            v = y;
            if(x <= round(c/2))
                u = x;
            else
                u = c - x + 1;
            end    
        else
            v = r - y + 1;
            if(x <= round(c/2))
                u = x;
            else
                u = c - x + 1;
            end
        end
        pow = -k1*( ( (v/by)^2 + (u/bx)^2 )/2 )^(5/6);
        psf_turb(y,x) = exp(pow);
    end
end
end


