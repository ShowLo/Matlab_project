function tonePlay = tone(freq_sample,frequence,last_time)
%输入参数
%freq_sample：采样频率
%frequence：乐音频率
%last_time：乐音持续时间
%输出参数
%tonePlay：一段由若干个乐音组合而成的音乐片段
tonePlay = [];
for i = 1:length(frequence)
    t = linspace(0,last_time(i) - 1/freq_sample,last_time(i) * freq_sample);
    part_tone = sin(2 * pi * frequence(i) * t);
    tonePlay = [tonePlay,part_tone];
end