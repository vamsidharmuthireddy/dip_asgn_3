function img_out = restore_turb(img_in,k1,k2)
[r,c,ch] = size(img_in);

psf_turb = give_turb_psf(r,c,k2);
psf = psf_turb;

psf_abs = abs(psf);
psf_conj = conj(psf);

% figure;imshow((psf_abs),[]);
% figure;imshow(fftshift(psf_abs),[]);
% surf([-c/2+1:c/2]/(c/2),[-r/2+1:r/2]/(r/2),fftshift(psf_abs))
% shading interp, camlight, colormap jet
% xlabel('PSF FFT magnitude')

psf = repmat(psf,1,1,ch);
psf_abs = repmat(psf_abs,1,1,ch);
psf_conj = repmat(psf_conj,1,1,ch);
psf_conj(find(psf < 0.01))= 0;
img_out = zeros(size(img_in));
% k2 = 0.1;

coeff = (psf_conj)./(psf_abs.^2 + k1);

im_f = fft2(img_in);
temp = coeff.*im_f;
img_out = real(ifft2(temp));

end

function psf_turb = give_turb_psf(r,c,k1)
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
        pow = -k1*(v^2 + u^2)^(5/6);
        psf_turb(y,x) = exp(pow);
    end
end
end


