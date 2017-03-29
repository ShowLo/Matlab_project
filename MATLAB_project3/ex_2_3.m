clear all;close all;clc;
load ('hall.mat');
right = dct2(hall_gray);
left = right;
right(:,end-3:end) = 0;                     %右四列置零
left(:,1:4) = 0;                                   %左四列置零
hall_gray_right = uint8(idct2(right)); %逆变换回去
hall_gray_left = uint8(idct2(left));
hold on;
%画出原图以及两个经过置零处理的图
subplot(1,3,1);
imshow(hall_gray);
title('原图');
subplot(1,3,2);
imshow(hall_gray_right);
title('右侧四列置零');
subplot(1,3,3);
imshow(hall_gray_left);
title('左侧四列置零');