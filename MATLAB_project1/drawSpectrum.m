function [f,fftdata] = drawSpectrum(musicGUI,Fs)
%输入参数
%musicGUI：合成的音乐
%Fs：采样频率
%输出参数
%f：频率范围
%fftdata：傅里叶变换结果

%周期延拓
%music = repmat(musicGUI,67,1);
len = length(musicGUI);                     %数据点总数
NFFT = 2^nextpow2(len);                   %采样点总数
y = 2 * fft(musicGUI,NFFT) / len;         %作傅里叶变换
f = Fs / 2 * linspace(0,1,NFFT / 2 + 1); %频率范围，频率间隔为Fs/NFFT
fftdata = abs(y(1 : NFFT / 2 + 1));        %由于fft结果的对称性，只取前半部分