clear all;close all;clc;
num = 33 ;                  %训练样本总数
L = 5;                          %2^(3L)种颜色
v = zeros(2^(3 * L),1);
for n = 1 : num
    image = imread(['Faces/',num2str(n),'.bmp']);
    v = v + getFeature(image,L);
end
v = v / num;                %取平均值得到训练出的人脸标准