function dcStream = DC_Stream(DC_coeff)
%输入参数
%DC_coeff：DC系数
%输出参数：
%dcStream：DC码流
pred_error = [DC_coeff(1,1),-diff(DC_coeff)]; %差分编码
len = length(pred_error);                              %码长
dcStream = [];
for n = 1 : len
    %Huffman编码在前，二进制码在后
    dcStream = [dcStream,DC_Huffman(pred_error(n)),myde2bi(pred_error(n))];
end
