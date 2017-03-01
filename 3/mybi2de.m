function de = mybi2de(bi)
%输入参数
%bi：二进制数
%输出参数
%de：十进制数
if bi(1) == 0                         %负数
    bi = ~bi;                          %逐位取反
    de = -bi2de(bi,'left-msb');%二进制转回十进制
else
    de = bi2de(bi,'left-msb');
end