clear all;close all;clc;
load ('hall.mat');
test = double(hall_color(25:32,25:32));         %截取图像的一部分
size_test = size(test);
sub = ones(size_test(1),size_test(2)) * 128;   %构造一个同样大小的元素全为128的矩阵
test_sub128 = dct2(test - sub);                    %在空域做减法然后变换
test_sub128_inTD = dct2(test) - dct2(sub);   %先变换再在变换域做减法
maxError = max(max(abs(test_sub128 - test_sub128_inTD))); %最大误差