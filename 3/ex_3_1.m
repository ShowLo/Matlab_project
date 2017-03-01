clear all;close all;clc;
load('hall.mat');
%待隐藏信息
str = ['Hello World! Matlab is interesting!',char(13),'Again--'];
str = strcat(str,str,str,str,str,str,str,str,str,str);
%空域隐藏信息
hall_hide = hide_spatial(hall_gray,str);
%解密
str_ds = decrypt_spatial(hall_hide);

%接下来进行JPEG编解码
%JPEG编码
[Height,Width] = size(hall_hide);
result = getDCTmatrix(hall_hide);
num = length(result(1,:));                  %获取总的块数
dcStream = DC_Stream(result(1,:));    %计算DC系数的码流
acStream = [];
for n = 1 : num                                 %计算各个块的AC系数的码流
    acStream = [acStream,AC_Stream(result(2:64,n))];
end

%JPEG解码
load('JpegCoeff.mat');
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

%编解码之后再解密
str_code = decrypt_spatial(hall_decode);
%解密失败，注释掉