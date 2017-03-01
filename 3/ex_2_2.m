clear all;close all;clc;
load ('hall.mat');
test = double(hall_color(25:32,25:32));                 %截取图像的一部分
sys_dct2 = dct2(test);                                          %系统提供的dct2函数
my_dct2 = mydct2(test);                                      %自己实现的二维DCT变换函数
maxError = max(max(abs(sys_dct2 - my_dct2)));   %最大误差