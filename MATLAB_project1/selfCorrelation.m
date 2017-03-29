function selfcorr = selfCorrelation(series)
%输入参数
%波形序列
%输出参数
%自相关序列
len = length(series);                 %序列长度
selfcorr = zeros(len,1);
for n = 1 : len
    selfcorr(n) = series' * [series(n : len);series(1 : n - 1)];
end
selfcorr = selfcorr / selfcorr(1); %归一化