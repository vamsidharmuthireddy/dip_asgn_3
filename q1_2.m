clear;
close all;
in = imread('Assign4_imgs/restore_02.jpg');
in = im2double(in);
% in = imresize(in,[10,10]);
% subplot(1,2,1);imshow(in)

k1=0.01;

k2=0.0025;
out_turb = restore_turb(in,k1,k2);

T=1;
a=1e-8 ;
b=0.004;
out_motion = restore_motion(in,k1,T,a,b);

len=10;
theta=0;
out_motion_2 = restore_motion_2(in,k1,len,theta);


figure;
subplot(2,2,1);imshow(in);title('input');
subplot(2,2,2);imshow(out_turb,[]);title('turb');
subplot(2,2,3);imshow(out_motion,[]);title('motion');
subplot(2,2,4);imshow(out_motion_2,[]);title('inbuilt');
% figure,imshow(out);


