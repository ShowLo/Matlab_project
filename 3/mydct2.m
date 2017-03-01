function myDct2 = mydct2(P)
%输入参数
%P：待处理图像矩阵
%输出参数
%myDct2：dct变换的结果
[N,M] = size(P);                                      %先得到输入方阵的大小       
if N ~= 8 || M ~= 8                                %判断是否为8×8矩阵
    error('输入的不是8×8矩阵');
else
    %构造cos函数需要的自变量矩阵
    col = linspace(pi / (2 * N),(N - 1) * pi / (2 * N),N - 1)';
    row = linspace(1,2 * N - 1,N);
    D = zeros(N,N);
    D(1,:) = ones(1,N) * sqrt(1 / N);           %第一行要特殊处理
    D(2:N,:) = sqrt(2 / N) * cos(col * row); %第二行到第N行利用之前构造的自变量矩阵
    myDct2 = D * P * D';                          %二维DCT变换C=DPD'
end