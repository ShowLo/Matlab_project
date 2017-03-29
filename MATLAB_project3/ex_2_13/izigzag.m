function dctMatrix = izigzag(ZigZag)
%输入参数
%ZigZag：Zig-Zag扫描结果
%输出参数
%dctMatrix：逆Zig-Zag扫描结果--DCT系数矩阵

%Zig-Zag扫描的行列顺序
row = [1,1:3,2,1,1:4,5:-1:1,1:6,7:-1:1,1:8,8:-1:2,3:8,8:-1:4,5:8,8:-1:6,7:8,8];
col = [1,2,1,1:3,4:-1:1,1:5,6:-1:1,1:7,8:-1:1,2:8,8:-1:3,4:8,8:-1:5,6:8,8,7,8];
dctMatrix = zeros(8,8);
%逆Zig-Zag扫描结果
for n = 1 : 64
    dctMatrix(row(n),col(n)) = ZigZag(n);
end
