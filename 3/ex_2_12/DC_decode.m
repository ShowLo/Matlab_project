function DC = DC_decode(dcStream,Height,Width)
%输入参数
%dcStream：DC码流
%Height：图像的高
%Width：图像的宽
%输出参数
%DC：量化后的直流分量
load('JpegCoeff.mat');
DC_len = ceil(Height / 8) * ceil(Width / 8);%量化后的直流分量的长度
DC = zeros(1,DC_len);
index = 1;                                                %索引，记录当前位于DC码流的哪一位
for n = 1 : DC_len
    for len = 2 : 9                                      %Huffman码长度范围从2到9
        row = find(DCTAB(:,1) == len);         %先匹配码长
                                                               %再匹配Huffman码
        match = find(ismember(DCTAB(row,2 : len + 1),dcStream(index : index + len - 1),'rows'));
        if ~isempty(match)                          %非空说明匹配成功
            Category = row(match) - 1; 
            index = index + len;                    %索引后移到量化后直流分量的二进制码第一位
                                                               %或下一个Huffman码开始处
            break;
        end
    end
    if Category == 0                                 %Category为零说明量化后的直流分量为零
        DC(n) = 0;
    else                                                     %否则需要将二进制码转为十进制数
        DC(n) = mybi2de(dcStream(index : index + Category - 1));
        index = index + Category;               %索引后移到下一个Huffman码开始处
    end
end
%反差分
for n = 2 : DC_len
    DC(n) = DC(n - 1) - DC(n);
end