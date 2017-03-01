function tonePlay = toneSynthesizer(freq_sample,frequence,last_time,series)
%输入参数
%freq_sample：采样频率
%frequence：乐音频率
%last_time：乐音持续时间
%series：傅里叶级数
%输出参数
%tonePlay：一个经过包络处理和添加了傅里叶级数幅度的各次谐波而成的乐音
envelope = [];                                                      %存放包络线
t = linspace(0,last_time - 1 / freq_sample,last_time * freq_sample);
len = length(t);
t1 = linspace(0,1,0.01 * len);
envelope(1 : 0.01 * len) = (t1);                              %第一段直线上升
t2 = linspace(0,-6,0.99 * len);
envelope(0.01 * len + 1 : len) = exp(t2);                %第二段指数下降
%添加各次谐波分量
tonePlay = (series * [sin(2 * pi * frequence * t);sin(2 * pi * 2 * frequence * t);sin(2 * pi * 3 * frequence * t);...
                    sin(2 * pi * 4 * frequence * t);sin(2 * pi * 5 * frequence * t);sin(2 * pi * 6 * frequence * t)]) .* envelope;