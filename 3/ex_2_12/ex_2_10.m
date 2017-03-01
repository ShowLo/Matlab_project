clear all;close all;clc;
load('jpegcodes.mat');
inLen = Height * Width * 8;                                 %输入文件的长度
outLen = length(dcStream) + length(acStream);  %输出码流的长度
compression_ratio = inLen / outLen;                   %压缩比