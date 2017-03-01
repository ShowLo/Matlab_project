function str = decrypt_spatial(image_hide)
%输入系数
%image_hide：隐藏着信息的图像
%输出系数
%str：恢复出来的隐藏信息
bitNum = 7;                                                              %存储每个字符所用的比特数
[Height,Width] = size(image_hide);
maxLenBit = floor(log2(Height * Width));                   %信息头部的长度
image_bin = de2bi(image_hide);                                %转为二进制码
binLen = bi2de(double(image_bin(1 : maxLenBit,1)'));%先提取头部的信息长度信息
%根据得到的信息长度，获取相应的信息，然后转回十进制，最后再转回字符
strBin = reshape(image_bin(maxLenBit + 1 : maxLenBit + binLen,1),bitNum,[])';
str = char(bi2de(strBin))';