function dcHuffman = DC_Huffman(DC_error)
%输入参数
%error：预测误差
%输出参数
%dcHuffman：直流分量预测误差的Huffman编码
load('JpegCoeff.mat');
%获取预测误差的Category值然后根据Category值取出Huffman编码
Category = category(DC_error); 
dcHuffman = DCTAB(Category + 1,2:DCTAB(Category + 1,1) + 1);