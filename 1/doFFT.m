%第八题，分析基频及谐波分量
clear all;close all;clc;
load Guitar;

%下面代码参考Matlab文档中fft函数的例子
%周期延拓
wave2proc = repmat(wave2proc,67,1);
len = length(wave2proc);                  %数据点总数
Fs = 8000;                                         %采样频率
NFFT = 2^nextpow2(len);                  %采样点总数
y = 2 * fft(wave2proc,NFFT) / len;      %作傅里叶变换
f = Fs / 2 * linspace(0,1,NFFT / 2 + 1);%频率范围，频率间隔为Fs/NFFT

plot(f,abs(y(1 : NFFT / 2 + 1)));           %由于fft结果的对称性，只画出前半部分
xlabel('Frequence/Hz');
ylabel('|y(f)|');