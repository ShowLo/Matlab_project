function str = decrypt_trans_1(matrix_hide)
%输入系数
%matrix_hide：隐藏着信息的量化后的DCT系数矩阵
%输出系数
%str：恢复出来的隐藏信息
bitNum = 7;                                            %存储每个字符所用的比特数
[Height,Width] = size(matrix_hide);
maxLenBit = floor(log2(Height * Width)); %信息头部的长度
for n = 1 : maxLenBit
    bin = de2bi(abs(matrix_hide(n)));         %将DCT系数取绝对值后再转为二进制    
    if matrix_hide(n) < 0                            %小于零时要取1补码
        bin = ~ bin;
    end
    len(n) = bin(1);
end
strLen = bi2de(len);                                 %得到信息长度
num = 1;                                                 %累计解得的字符数量
bit_add = 1;                                             %累计字符比特数，每bitNum个就重置为1
for n = maxLenBit + 1 : maxLenBit + strLen
    bin = de2bi(abs(matrix_hide(n)));         %将DCT系数取绝对值后再转为二进制    
    if matrix_hide(n) < 0                            %小于零时要取1补码
        bin = ~ bin;
    end
    ascii(bit_add) = bin(1);                         %字符的ascii码的二进制
    bit_add = bit_add + 1;                         %累加字符比特数
    if bit_add > bitNum                             %已得到一个字符
        str(num) = char(bi2de(ascii));           %转为字符
        num = num + 1;                              %累加解得的字符数量
        bit_add = 1;                                     %重置
    end
end