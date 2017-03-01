clear all;close all;clc;
load ('hall.mat');
chessBoard = hall_color;
[length,width,~] = size(hall_color);              %获取图像大小
grid_len = length / 8;                                  %每个格的长
grid_wid = width / 8;                                   %每个格的宽
%得到基本的2乘2黑白格
baseGrid = [zeros(grid_len,grid_wid),ones(grid_len,grid_wid);
                   ones(grid_len,grid_wid),zeros(grid_len,grid_wid)];
%扩大四倍
blackWhiteGrid = repmat(baseGrid,4,4);
%最后用RGB矩阵分别与黑白格矩阵点乘
chessBoard(:,:,1) = double(hall_color(:,:,1)).*blackWhiteGrid;
chessBoard(:,:,2) = double(hall_color(:,:,2)).*blackWhiteGrid;
chessBoard(:,:,3) = double(hall_color(:,:,3)).*blackWhiteGrid;
imwrite(chessBoard,'chessboard.jpg','jpg');