clc;
clear;
load ica.mat;
img = imread('lena.jpg');
% img = rgb2gray(img);
[rows cols] = size(img);
img = double(img);
img = img ./ max(max(img));
img1 = img;
img = imnoise(img,'gaussian',0.001);
X = double(img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
W = (W * real((W' * W)^(-0.5)));
result = zeros(256,256);
for i = 1:256-7
    i
    for j = 1:256-7
        tmp = X(i: i + 7, j: j + 7);
        tmp = reshape(tmp,[64 1]);
        tran = mean(tmp);
        tmp = tmp - tran;
        ica = W * tmp;
        mean_ = mean(ica);
        mask = ica > 3 * mean_;
        ica = ica .* mask;
        ica_rec = W' * ica;
        result(i: i + 7, j: j + 7) = ( result(i: i + 7, j: j + 7) + reshape(ica_rec,[8 8]) + tran );
    end
end
w=fspecial('gaussian',[5 5])
im=imfilter(result./64,w);
imshow(im, [0 1])
figure
imshow((img))
figure
imshow(img1)

comp = im(16:end-16, 16:end-16);
noise = img(16:end-16, 16:end-16);
orig = img1(16:end-16, 16:end-16);
psnr(orig, comp)
psnr(orig, noise)
psnr(orig, orig)

