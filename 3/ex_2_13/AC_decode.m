function AC = AC_decode(acStream,Height,Width)
%输入参数
%acStream：AC码流
%Height：图像的高
%Width：图像的宽
%输出参数
%AC：量化后的AC系数
load('JpegCoeff.mat');
AC_len = ceil(Height / 8) * ceil(Width / 8);%量化后AC系数的长度
AC = zeros(63,AC_len);
ZRL = [ones(1,8),0,0,1];                            %特殊，16个连0
EOB = [1,0,1,0];                                        %块结束
%在原先ACTAB矩阵的最后添加上16连零和结束标志信息
myACTAB = [ACTAB;0,0,4,EOB,zeros(1,12);15,0,11,ZRL,zeros(1,5)];
index = 1;                                                %索引，指示当前位于AC码流的哪一位
for n = 1 : AC_len
    row_index = 1;                                     %行索引，指示当前位于AC系数特定列的哪一行
    while true
        for len = [2:12,15:16]                        %Huffman码长只有1到12和15,16几种
            row = find(myACTAB(:,3) == len); %先匹配长度
                                                                %再匹配Huffman码
            match = find(ismember(myACTAB(row,4 : len + 3),acStream(index : index + len - 1),'rows'));
            if ~isempty(match)                       %非空说明匹配成功
                Run = myACTAB(row(match),1);%获取Run
                Size = myACTAB(row(match),2);%获取Size
                index = index + len;                 %索引后移到量化后AC系数的二进制码第一位
                                                                %或者下一个Huffman码的开始处
                break;
            end
        end
        if Size ~= 0                                       %正常情况
            %将二进制码转为十进制数
            AC(row_index + Run,n) = mybi2de(acStream(index : index + Size - 1));
            index = index + Size;                    %索引后移到下一个Huffman码的开始处
            row_index = row_index + Run + 1;%行索引移动到当前非零AC系数处
        elseif Run == 0                                 %Run == 0 且 Size == 0 即块结束符，跳出循环进行下一列计算
            break;
        else                                                  %Run ！= 0 且 Size == 0 即16个连零，将行索引加16
            row_index = row_index + 16;
        end
    end
end
