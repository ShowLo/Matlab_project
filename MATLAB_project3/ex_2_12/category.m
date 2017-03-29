function Category = category(DC_error)
%输入参数
%DC_error：DC预测误差
%输出参数
%Category：DC预测误差的Category值
Category = ceil(log2(abs(DC_error) + 1));