clear all;close all;clc;
load ('hall.mat');
redcicle = hall_color;
[length,width,~] = size(redcicle);           %获取图像大小
r = min(length,width) / 2;                     %获取圆半径
center_row = length / 2;                       %获取圆心
center_col = width / 2;

for k = 1 : length
    for n = 1 : width
        %如果在圆内就置为红色
        if (k - center_row)^2 + (n - center_col)^2 <= r^2
            redcicle(k,n,:) = [255,0,0];
        end
    end
end

imwrite(redcicle,'redCicle.jpg','jpg');