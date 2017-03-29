clear all;close all;clc;
load('hall.mat');
[Height,Width] = size(hall_gray);
result = getDCTmatrix(hall_gray);
num = length(result(1,:));                  %获取总的块数
dcStream = DC_Stream(result(1,:));    %计算DC系数的码流
acStream = [];
for n = 1 : num                                 %计算各个块的AC系数的码流
    acStream = [acStream,AC_Stream(result(2:64,n))];
end
save('jpegcodes.mat','dcStream','acStream','Height','Width');