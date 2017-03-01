function ZigZag = zigzag(dctMatrix)
%输入参数
%dctMatrix：DCT系数矩阵
%输出参数
%ZigZag：Zig-Zag扫描结果
[N,M] = size(dctMatrix);                          %先得到输入方阵的大小       
if N ~= 8 || M ~= 8                                %判断是否为8×8矩阵
    error('输入的不是8×8矩阵');
else
    %Zig-Zag扫描的行列顺序
    row = [1,1:3,2,1,1:4,5:-1:1,1:6,7:-1:1,1:8,8:-1:2,3:8,8:-1:4,5:8,8:-1:6,7:8,8];
    col = [1,2,1,1:3,4:-1:1,1:5,6:-1:1,1:7,8:-1:1,2:8,8:-1:3,4:8,8:-1:5,6:8,8,7,8];
    %Zig-Zag扫描结果
    ZigZag = dctMatrix(row + (col - 1) * size(dctMatrix,1));
end
