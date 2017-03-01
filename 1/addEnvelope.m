%第二题，添加包络
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
%%原调
freq = [freq_5;freq_5;freq_6;freq_2;freq_1;freq_1;freq_6_octave_below;freq_2];

%%第三题--升八度
%freq = 2 * [freq_5;freq_5;freq_6;freq_2;freq_1;freq_1;freq_6_octave_below;freq_2];

%%第三题--降八度
%freq = 0.5 * [freq_5;freq_5;freq_6;freq_2;freq_1;freq_1;freq_6_octave_below;freq_2];

%各个音的持续时间
last_time = beatTime * [1;1/2;1/2;2;1;1/2;1/2;2];
%用一系列乐音信号拼出一个片段
tonePlay = toneEnvelope(freq_sample,freq,last_time);
%第三题--升高半个音阶
%tonePlay = resample(tonePlay,10000,10595);
%播放
sound(tonePlay,freq_sample);