function tuneName = tune(frequence)
%输入参数
%frequence：频率
%输出参数
%toneName：音调名
multiple = 2^(1/12);                                %相邻音倍乘系数
n = -4 : 19;
standardTune = 220 * multiple .^ n;        %从174.61Hz(F-)到659.25Hz(E+)
ceil standardName;
standardName = {'F-';'bG-';'G-';'bA';'A';'bB';'B';'C';'bD';'D';'bE';'E';'F';'bG';'G';...
                           'bA+';'A+';'bB+';'B+';'C+';'bD+';'D+';'bE+';'E+'};
len = length(frequence);
tuneName = cell(len,1);
for index = 1 : len
    err = abs(standardTune - frequence(index));
    %选择误差最小的
    [minError,minIndex] = min(err);
    %返回音调名
    tuneName{index} = standardName{minIndex};
end