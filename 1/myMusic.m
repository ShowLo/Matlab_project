%第五题，自选其他音乐合成
clear all;close all;clc;

freq_sample = 8000;                     %采样频率
T = 1/freq_sample;                       %采样周期
beatNum = 4;                              %每小节的拍数
barNum = 4;                                %小节数
beatTime = 0.5;                           %每小拍的时间

%在C调下各个音的频率
freq_7_octave_below = 246.94;    %低八度的7
freq_6_octave_below = 220;         %低八度的6
freq_1 = 261.63;
freq_2 = 293.66;
freq_3 = 329.63;
freq_4 = 349.23;
freq_5 = 392;
freq_6 = 440;
freq_7 = 493.88;
%组装乐曲，名侦探柯南插曲《如果有你在》
freq = [freq_1;freq_7_octave_below;freq_6_octave_below;freq_3;freq_1;freq_6_octave_below;...
            freq_7_octave_below;freq_4;freq_3;freq_2;freq_1;freq_2;freq_1;freq_2;freq_3;freq_1;...
            freq_7_octave_below;freq_6_octave_below;freq_2;freq_1;freq_7_octave_below;freq_1;...
            freq_6_octave_below;freq_3;freq_1;freq_2;freq_6;freq_5;freq_4;freq_3;freq_2;freq_3];

%各个音的持续时间
last_time = beatTime * [1/2;1/2;1;2;1/2;1/2;1;1;1/2;3/2;1/2;1/2;1/2;1/2;1;1/2;1/2;1;1;1/2;3/2;...
                                     1;1;1;1;1;1;1;1;1/2;1/2;6];
%用一系列乐音信号拼出一个片段
tonePlay = toneHarmonics(freq_sample,freq,last_time);
%归一化
tonePlay = tonePlay/max(abs(tonePlay));
%播放
sound(tonePlay,freq_sample);