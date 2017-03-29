function bi = myde2bi(de)
%输入参数
%de：十进制数
%输出参数
%bi：二进制数
bi = de2bi(abs(de),'left-msb');  %先取绝对值然后求其二进制
if de <0                                   %如果小于零的话取其1补码
    bi = ~bi;
elseif de == 0                          %如果等于零的话直接置空
    bi = [];
end