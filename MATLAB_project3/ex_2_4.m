clear all;close all;clc;
load ('hall.mat');
dctMatrix = dct2(hall_gray);
transpose = dctMatrix';                     %做转置
rot_90 = rot90(dctMatrix);                 %旋转90度
rot_180 = rot90(dctMatrix,2);             %旋转180度
%逆变换恢复
hall_tran = uint8(idct2(transpose));
hall_rot90 = uint8(idct2(rot_90));
hall_rot180 = uint8(idct2(rot_180));
%画图
hold on;
subplot(2,2,1);
imshow(hall_gray);
title('原图');
subplot(2,2,2);
imshow(hall_tran);
title('做转置');
subplot(2,2,3);
imshow(hall_rot90);
title('旋转90度');
subplot(2,2,4);
imshow(hall_rot180);
title('旋转180度');