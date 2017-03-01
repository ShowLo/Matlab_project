function matrix_hide = hide_trans_3(matrix,str)
%输入参数
%matrix：用来隐藏信息的DCT系数矩阵
%str：要隐藏的信息
%输出参数
%matrix_hide：经过处理后隐藏了信息的DCT系数矩阵
bitNum = 7;                                                  %根据ASCII码的数值范围，用7比特存储每个字符
[rowNum,capacity] = size(matrix);
maxLenBit = ceil(log2(capacity));                   %隐藏的信息不超过2^maxLenBit比特
num = uint8(str);                                           %先将待隐藏信息从字符串
bin = double(de2bi(num,bitNum));                %再转为二进制码
bin = bin * 2 - 1;                                            %将0转为-1
streamLen = length(num) * bitNum;              %计算二进制码的长度
if streamLen + maxLenBit > capacity             %检查是否超出范围
    error('隐藏信息数过多，超过容量');
end
len_bi = double(de2bi(streamLen,maxLenBit));%文件长度的二进制码
len_bi = len_bi * 2 - 1;                                     %同样要将0转为-1
matrix_hide = matrix;
%二进制码流，头部的maxLenBit位存储的是信息长度信息
binStream = [len_bi';reshape(bin',[streamLen,1])];
for n = 1 : streamLen + maxLenBit
    last_index = find(matrix(:,n),1,'last');            %找到最后一个非零系数
    if last_index == rowNum                             %如果是最后一个系数就直接替换
        matrix_hide(last_index,n) = binStream(n);
    else                                                             %否则写在其后
        matrix_hide(last_index + 1,n) = binStream(n);
    end
end