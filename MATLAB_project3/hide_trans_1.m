function matrix_hide = hide_trans_1(matrix,str)
%输入参数
%matrix：用来隐藏信息的DCT系数矩阵
%str：要隐藏的信息
%输出参数
%matrix_hide：经过处理后隐藏了信息的DCT系数矩阵
[Height,Width] = size(matrix);                      %获取用来隐藏信息的矩阵的大小
bitNum = 7;                                                %根据ASCII码的数值范围，用7比特存储每个字符
maxLenBit = floor(log2(Height * Width));       %隐藏的信息最多可以有2^maxLenBit比特
num = uint8(str);                                         %先将待隐藏信息从字符串转为数字
bin = de2bi(num,bitNum);                           %再转为二进制码
streamLen = length(num) * bitNum;            %计算二进制码的长度
if streamLen + maxLenBit > Height * Width %检查是否超出范围
    error('隐藏信息数过多，超过容量');
end
matrix_hide = matrix;
%二进制码流，头部的maxLenBit位存储的是信息长度信息
binStream = [de2bi(streamLen,maxLenBit)';reshape(bin',[streamLen,1])];
for n = 1 : length(binStream)
    bin = de2bi(abs(matrix(n)));          %将DCT系数取绝对值后再转为二进制    
    if matrix(n) < 0                             %小于零时要取1补码
        bin = ~ bin;
    end
    bin(1) = binStream(n);                  %在最低位隐藏信息位
    if matrix(n) < -1                            %-1对应的补码为0，只好当做0处理，否则解密会出错
        bin = ~bin;                               %取回负数绝对值对应的二进制码
        matrix_hide(n) = -bi2de(bin);     %转回十进制，负数加负号
    else
        matrix_hide(n) = bi2de(bin);
    end
end