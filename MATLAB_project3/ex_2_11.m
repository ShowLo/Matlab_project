clear all;close all;clc;
load('jpegcodes.mat');
load('JpegCoeff.mat');
load('hall.mat');
row = ceil(Height/8);                                   %横向分块数
col = ceil(Width/8);                                     %纵向分块数
DC = DC_decode(dcStream,Height,Width);  %DC系数
AC = AC_decode(acStream,Height,Width);   %AC系数
result = [DC;AC];
hall_decode = uint8(zeros(Height,Width));
for r = 1 : row
    for c = 1 : col
        %先逆Zig-Zag变换得到量化后的DCT系数矩阵
        Quantification = izigzag(result(:,col * (r - 1) + c));
        %然后反量化
        dctMatrix = Quantification.*QTAB;
        %进行DCT逆变换并作拼接
        hall_decode(8 * (r - 1) + 1 : 8 * r,8 * (c - 1) + 1 : 8 * c) = idct2(dctMatrix) + 128;
    end
end
%画图
hold on;
subplot(1,2,1);
imshow(hall_gray);
title('原图');
subplot(1,2,2);
imshow(hall_decode);
title('编解码后的图');
%计算峰值信噪比PSNR
MSE = sum(sum((double(hall_decode) - double(hall_gray)).^2)) / (Height * Width);
PSNR = 10 * log10(255^2 / MSE);