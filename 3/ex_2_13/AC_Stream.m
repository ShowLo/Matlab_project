function acStream = AC_Stream(AC)
%输入参数
%block：8×8图像块
%输出参数
%AC：AC系数
load('JpegCoeff.mat');
ZRL = [ones(1,8),0,0,1];            %特殊，16个连0
EOB = [1,0,1,0];                        %块结束
acStream = [];
Run = 0;
for n = 1 : 63
    if AC(n) == 0
        Run = Run + 1;               %行程Run，累计0的个数
    else
        if Run >= 48                   %插入3个ZRL
            acStream = [acStream,repmat(ZRL,1,3)];
            Run = Run - 48;
        elseif Run >= 32             %插入2个ZRL
            acStream = [acStream,repmat(ZRL,1,2)];
            Run = Run - 32;
        elseif Run >= 16             %插入1个ZRL
            acStream = [acStream,ZRL];
            Run = Run - 16;
        end
        %根据Run和Size获取行数，并依此获取Run/Size的Huffman编码
        row = 10 * Run + category(AC(n));
        %Huffman码在前，二进制码在后
        acStream = [acStream,ACTAB(row,4 : ACTAB(row,3) + 3),myde2bi(AC(n))];
        Run = 0;                          %行程Run清零
    end
end
acStream = [acStream,EOB];    %最后加上块结束符