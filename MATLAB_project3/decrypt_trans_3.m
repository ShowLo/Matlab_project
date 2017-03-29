function str = decrypt_trans_3(matrix_hide)
%输入系数
%matrix_hide：隐藏着信息的量化后的DCT系数矩阵
%输出系数
%str：恢复出来的隐藏信息
bitNum = 7;                                                %根据ASCII码的数值范围，用7比特存储每个字符
capacity = length(matrix_hide(1,:));
maxLenBit = ceil(log2(capacity));                 %信息头部的长度
for n = 1 : maxLenBit
    len_bi(n) = (matrix_hide(find(matrix_hide(:,n),1,'last'),n) + 1) / 2;
end
strLen = bi2de(len_bi);                                 %获取信息长度
num = 1;                                                     %累计解得的字符数量
bit_add = 1;                                                 %累计字符比特数，每bitNum个就重置为1
for n = maxLenBit + 1 : maxLenBit + strLen
     ascii(bit_add) = (matrix_hide(find(matrix_hide(:,n),1,'last'),n) + 1) / 2;
     bit_add = bit_add + 1;                            %累加字符比特数
     if bit_add > bitNum                                %已得到一个字符
         str(num) = char(bi2de(ascii));              %转为字符
         num = num + 1;                                 %累加解得的字符数量
         bit_add = 1;                                        %重置
     end
end