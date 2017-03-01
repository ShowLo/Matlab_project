clear all;close all;clc;
load('hall.mat');
load('snow.mat');
hall_gray = snow;           %将测试图像换为雪花图像
save('hall.mat','hall_gray');