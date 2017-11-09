clear;
close all;
in = imread('Assign4_imgs/restore_04.jpg');
in = im2double(in);
% in = imresize(in,[10,10]);
% subplot(1,2,1);imshow(in)

k1=0.04;
k2=0.001;
out_turb = restore_turb(in,k1,k2);

k1=0.01;
T=1;
a=0.00001 ;
b=0.0001;
out_motion = restore_weiner(in,k1,T,a,b);
% WEIGHT = edge(rgb2gray(in),'sobel',.08);
% se = strel('disk',2);
% WEIGHT = 1-double(imdilate(WEIGHT,se));
% WEIGHT([1:3 end-(0:2)],:) = 0;
% WEIGHT(:,[1:3 end-(0:2)]) = 0;
% figure; imshow(WEIGHT); title('Weight array');

k1=0.04;
len=5;
theta=45;
out_motion_2 = restore_motion_2(in,k1,len,theta);


figure;
subplot(2,2,1);imshow(in);title('input');
subplot(2,2,2);imshow(out_turb,[]);title('turb');
subplot(2,2,3);imshow(out_motion,[]);title('motion');
subplot(2,2,4);imshow(out_motion_2,[]);title('inbuilt');
% figure,imshow(out);


