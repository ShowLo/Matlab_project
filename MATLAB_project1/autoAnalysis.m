%第九题，自动分析音调和节拍
clear all;close all;clc;
[fmt,Fs] = audioread('fmt.wav');

[b,a] = butter(10,[80 / (Fs / 2),2000 / (Fs / 2)]);
fmt = filter(b,a,fmt);                          %带通滤波，80Hz~2kHz
absFmt = abs(fmt);                           %取绝对值

T = 1 / Fs;                                         %采样周期
len = length(fmt);                             %采样点总数
t = 0 : T : len / Fs - T;                        %时域
halfBeat = Fs / 4;                              %半拍的长度
halfBeatNum = floor(len / halfBeat); %这段乐曲包含的半拍拍数
divide = zeros(1,len);                         %存放划分信息
divide(end) = 1;
broken = 4;                                       %每半拍再划分为4块

%去掉最后不超过半拍长度的采样点
absFmtBeat = reshape(absFmt(1:halfBeat * halfBeatNum),halfBeat / broken,halfBeatNum * broken);
%找出每个半拍中的最大值及索引
[beatMax,beatMaxIndex] = max(absFmtBeat);
%找出每个最大值在absFmt中真正的位置
for i = 1 : halfBeatNum * broken
    beatMaxIndex(i) = beatMaxIndex(i) + halfBeat / broken * (i - 1);
end
 
threhold = 0.04;                                %阈值
index = 1;                                         %块索引，指示到了哪一块
toneNum = 1;                                   %找到的乐音数
while index < halfBeatNum * broken
    interval = 0;                                  %块与块之间的间隔
    %当前块的最大值比之后块的最大值小，找出一个递增的块序列
    while index < halfBeatNum * broken && beatMax(index) < beatMax(index + 1)
        interval = interval + 1;
        index = index + 1;                    %块索引后移
    end
    %超出阈值，认为已经有一个新的乐音
    if(beatMax(index) - beatMax(index - interval) > threhold)
        %标记分割处并记住索引
        divide((index - 1) * halfBeat / broken) = 1;
        divideIndex(toneNum) = (index - 1) * halfBeat / broken;
        toneNum = toneNum + 1;        %乐音数加1
    end
    index = index + 1;                        %继续下一个块
end

divideIndex(toneNum) = len;            %最后一处分割处默认为乐曲结束处

frequence = zeros(toneNum - 1,1);
dotNum = zeros(toneNum - 1,1);
harmonicsAmpli = zeros(toneNum - 1,6);
%对分割后的各个部分做傅里叶分析，基本按照第八题的代码来做
for n = 1 : toneNum - 1
    %先作周期延拓
    dotNum(n) = divideIndex(n+1) - divideIndex(n);
    cycle = repmat(fmt(divideIndex(n) : divideIndex(n+1)),100,1);
    dataNum = length(cycle);              %数据点总数
    NFFT = 2^nextpow2(dataNum);     %采样点总数
    y = 2 * fft(cycle,NFFT) / dataNum;  %作傅里叶变换
    fftData = abs(y(1 : NFFT / 2 + 1));   %由于fft结果的对称性，只取前半部分
    fftData = fftData / max(fftData);     %归一化
    f = Fs/2 * linspace(0,1,NFFT/2 + 1); %频率范围，频率间隔为Fs / NFFT
    
    minAmpli = 0.35;                            %最小峰值
    [maxAmpli,maxFreq] = max(fftData);%找出最大峰
    error = floor(2 * NFFT / Fs);             %误差允许范围为2Hz
    %找出可能的基波，如若找到说明之前的最大峰为二次谐波
    [halfAmpli,halfFreq] = max(fftData(floor(maxFreq / 2) - error : floor(maxFreq / 2) + error));
    if(halfAmpli > minAmpli)
        freq = halfFreq + floor(maxFreq / 2) - error - 1;
        ampli = halfAmpli;
    else
        freq = maxFreq;
        ampli = maxAmpli;
    end
    frequence(n) = f(freq);                   %真实频率  
    
    harmonicsAmpli(n,1) = ampli;
    %找出各次谐波幅度
    for series = 2 : 6
        harmonicsAmpli(n,series) = max(fftData(freq * series - error : freq * series + error));
    end
end

tuneName = tune(frequence);            %tuneName为cell数组

beatNum = beat(dotNum,Fs);             %返回每个乐音占多少个1/16拍

info = struct('tuneName','harmonicsAmpli');
for num = 1 : toneNum - 1
    info(num).tuneName = tuneName{num};
    info(num).harmonicsAmpli = harmonicsAmpli(num,:);
end
save('info.mat','info');