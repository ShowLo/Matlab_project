function result = getDCTmatrix(image)
%输入参数
%image：灰度图像矩阵
%输出参数
%result：经过分块、DCT变换、量化处理及Zig-Zag扫描的DCT系数矩阵
load('JpegCoeff.mat');
[Height,Width] = size(image);                   %获得灰度图像的大小
%当图像尺寸不是8的整数倍时需要进行图像的延伸，所以这里需要向上取整
row = ceil(Height/8);                  
col = ceil(Width/8);
image_extend = zeros(row * 8,col * 8);      %延伸后的图像矩阵，延伸部分补零
image_extend(1:Height,1:Width) = image; %存放原来的灰度图像矩阵
result = zeros(64,row * col);                       %预定义存放最终结果的矩阵
for r = 1 : row
    for c = 1 : col
        %取出小图像块，进行预处理然后进行DCT变换
        dctMatrix = dct2(image_extend(8 * (r - 1) + 1 : 8 * r,8 * (c - 1) + 1 : 8 * c) - 128);
        Quantification = round(dctMatrix./QTAB);            %量化
        result(:,col * (r - 1) + c) = zigzag(Quantification)';  %Zig-Zag扫描
    end
end