function tonePlay = toneEnvelope(freq_sample,frequence,last_time)
%输入参数
%freq_sample：采样频率
%frequence：乐音频率
%last_time：乐音持续时间
%输出参数
%tonePlay：一段由若干个乐音组合且经过包络处理而成的音乐片段
tonePlay = [];
for i = 1 : length(frequence)
    envelope = [];                                                          %存放包络线
    t = linspace(0,last_time(i) - 1 / freq_sample,last_time(i) * freq_sample);
    len = length(t);
    t1 = linspace(-6,0,0.2 * len);
    envelope(1 : 0.2 * len) = exp(t1);                              %第一段指数上升
    t2 = linspace(0,-0.5,0.1 * len);
    envelope(0.2 * len + 1 : 0.3 * len) = exp(t2);             %第二段指数下降
    envelope(0.3 * len + 1 : 0.65 * len) = exp(t2(end));    %第三段水平线
    t4 = linspace(t2(end),-6,0.35 * len);
    envelope(0.65 * len + 1 : len) = exp(t4);                    %第四段指数下降
    part_tone = sin(2 * pi * frequence(i) * t).*envelope;   %原来的信号乘上包络信号
    tonePlay = [tonePlay,part_tone];
end