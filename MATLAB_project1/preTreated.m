%第七题，预处理以去除真实乐曲中的非线性谐波和噪声
clear all;close all;clc;
load Guitar;

selfcorr = selfCorrelation(realwave);   %先做自相关
peaksNum = findpeaks(selfcorr,'minpeakheight',0.8);
periodNum = length(peaksNum) + 1; %周期数
len = length(realwave);                       %采样点总数
%增加10倍的采样点
extensionWave = resample(realwave,10 * len,len);
averageWave = zeros(len,1);
for n = 1 : periodNum
    averageWave =averageWave + extensionWave(len * (n - 1) + 1 : len * n);
end
%取平均
averageWave = averageWave / periodNum;
%周期延拓
cycleWave = repmat(averageWave,periodNum,1);
%采样点恢复为原来的大小
preTreatedWave = resample(cycleWave,len,10 * len);