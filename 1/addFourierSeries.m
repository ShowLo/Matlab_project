﻿%第十题，用第8题得到的傅里叶级数重新完成第四题
clear all;close all;clc;

freq_sample = 8000;                     %采样频率
T = 1/freq_sample;                       %采样周期
beatNum = 2;                              %每小节的拍数
barNum = 4;                                %小节数
beatTime = 0.5;                           %每小拍的时间

%在F调下各个音的频率
freq_6_octave_below = 293.66;    %低八度的6
freq_1 = 349.23;
freq_2 = 392;
freq_5 = 523.25;
freq_6 = 587.33;
freq = [freq_5;freq_5;freq_6;freq_2;freq_1;freq_1;freq_6_octave_below;freq_2];

%各个音的持续时间
last_time = beatTime * [1;1/2;1/2;2;1;1/2;1/2;2];
%傅里叶级数
series = [0.049656,0.05307,0.04559,0.05966,0.00267,0.00432,0.01627,0.00666,0.00709,0.0027];
%用一系列乐音信号拼出一个片段
tonePlay = toneFourier(freq_sample,freq,last_time,series);
%归一化
tonePlay = tonePlay/max(abs(tonePlay));
%播放
sound(tonePlay,freq_sample);