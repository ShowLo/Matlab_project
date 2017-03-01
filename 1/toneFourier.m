function tonePlay = toneFourier(freq_sample,frequence,last_time,series)
%输入参数
%freq_sample：采样频率
%frequence：乐音频率
%last_time：乐音持续时间
%series：傅里叶级数
%输出参数
%tonePlay：一段由若干个乐音组合且经过包络处理和添加了傅里叶级数幅度的各次谐波而成的音乐片段
tonePlay = [];
for i = 1 : length(frequence)
    envelope = [];                                                      %存放包络线
    t = linspace(0,last_time(i) - 1 / freq_sample,last_time(i) * freq_sample);
    len = length(t);
    t1 = linspace(0,1,0.01 * len);
    envelope(1 : 0.01 * len) = (t1);                              %第一段直线上升
    t2 = linspace(0,-6,0.99 * len);
    envelope(0.01 * len + 1 : len) = exp(t2);                %第二段指数下降
    %添加各次谐波分量
    part_tone = (series * [sin(2 * pi * frequence(i) * t);sin(2 * pi * 2 * frequence(i) * t);sin(2 * pi * 3 * frequence(i) * t);...
                        sin(2 * pi * 4 * frequence(i) * t);sin(2 * pi * 5 * frequence(i) * t);sin(2 * pi * 6 * frequence(i) * t);...
                        sin(2 * pi * 7 * frequence(i) * t);sin(2 * pi * 8 * frequence(i) * t);sin(2 * pi * 9 * frequence(i) * t);...
                        0.0027 * sin(2 * pi * 10 * frequence(i) * t)]) .* envelope;
    tonePlay = [tonePlay,part_tone];
end