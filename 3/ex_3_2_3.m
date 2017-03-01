clear all;close all;clc;
load('hall.mat');
dctMatrix = getDCTmatrix(hall_gray);
%待隐藏信息
str = ['Hello World!Matlab is interesting!',char(13),'Again?No'];
%将信息隐藏在DCT系数矩阵之中
dctMatrix_hide = hide_trans_3(dctMatrix,str);

%熵编码
num = length(dctMatrix_hide(1,:));                 %获取总的块数
dcStream = DC_Stream(dctMatrix_hide(1,:));   %计算DC系数的码流
acStream = [];
for n = 1 : num                                              %计算各个块的AC系数的码流
    acStream = [acStream,AC_Stream(dctMatrix_hide(2:64,n))];
end

%解码
load('JpegCoeff.mat');
[Height,Width] = size(hall_gray);
row = ceil(Height/8);                                       %横向分块数
col = ceil(Width/8);                                         %纵向分块数
DC = DC_decode(dcStream,Height,Width);      %DC系数
AC = AC_decode(acStream,Height,Width);      %AC系数
result = [DC;AC];
hall_decode = uint8(zeros(Height,Width));
for r = 1 : row
    for c = 1 : col
        %先逆Zig-Zag变换得到量化后的DCT系数矩阵
        Quantification = izigzag(result(:,col * (r - 1) + c));
        %然后反量化
        dctMatrix8by8 = Quantification.*QTAB;
        %进行DCT逆变换并作拼接
        hall_decode(8 * (r - 1) + 1 : 8 * r,8 * (c - 1) + 1 : 8 * c) = idct2(dctMatrix8by8) + 128;
    end
end

%第一种方法，直接通过隐藏了信息的DCT系数矩阵经熵编解码得到的DCT系数矩阵解密
str_dt1= decrypt_trans_3(result);
%第二种方法，通过隐藏了信息的图像经过处理得到的DCT系数矩阵解密
str_dt2 = decrypt_trans_3(getDCTmatrix(hall_decode));