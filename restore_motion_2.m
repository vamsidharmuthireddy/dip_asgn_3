function img_out = restore_motion_2(img_in,k1,len,theta)
[r,c,ch] = size(img_in);

psf_motion_2 = fspecial('motion', len, theta);
psf = psf_motion_2;
psf = fft2(psf,r,c);

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
