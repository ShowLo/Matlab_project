function musicGUI = music(frequence,last_time,Fs,instrument)
%输入参数
%frequence：各个乐音的频率
%last_time：各个乐音的持续时间
%Fs：采样频率
%instrument：乐器名
%输出参数
%合成的乐曲

%各种乐器的傅里叶级数
seriesGuitar = [0.04956,0.05307,0.04559,0.05966,0.00267,0.00432];
seriesOrgan = [1,0.2,0.3];
seriesPiano = [2.48,1.3,1.5,1.1];

len = length(frequence);                                                    %乐音个数
musicGUI = [];                                                                   %存放合成音乐
if (strcmp(instrument,'吉他'))                                              %合成吉他音色的音乐
    for n = 1 : len
        envelope = [];                                                            %存放包络线
        t = linspace(0,last_time(n) - 1 / Fs,last_time(n) * Fs);   %乐音时间
        tLen = length(t);
        t1 = linspace(0,1,0.01 * tLen);
        envelope(1 : 0.01 * tLen) = (t1);                                  %第一段直线上升
        t2 = linspace(0,-6,0.99 * tLen);
        envelope(0.01 * tLen + 1 : tLen) = exp(t2);                 %第二段指数下降
        %合成一个乐音
        part_tone = (seriesGuitar * [sin(2 * pi * frequence(n) * t);sin(2 * pi * 2 * frequence(n) * t);...
                            sin(2 * pi * 3 * frequence(n) * t);sin(2 * pi * 4 * frequence(n) * t);...
                            sin(2 * pi * 5 * frequence(n) * t);sin(2 * pi * 6 * frequence(n) * t)]) .* envelope;
        part_tone = part_tone / max(part_tone);                     %归一化
        musicGUI = [musicGUI,part_tone];                              %组合各个乐音        
    end
    musicGUI = musicGUI / max(musicGUI);                         %归一化
elseif (strcmp(instrument,'风琴'))                                         %合成风琴音色的音乐
    for n = 1 : len
        envelope = [];                                                      
        t = linspace(0,last_time(n) - 1 / Fs,last_time(n) * Fs);
        tLen = length(t);
        t1 = linspace(-6,0,0.2 * tLen);
        envelope(1 : 0.2 * tLen) = exp(t1);                               %第一段指数上升
        t2 = linspace(0,-0.5,0.1 * tLen);
        envelope(0.2 * tLen + 1 : 0.3 * tLen) = exp(t2);            %第二段指数下降
        envelope(0.3 * tLen + 1 : 0.65 * tLen) = exp(t2(end));  %第三段水平线
        t4 = linspace(t2(end),-6,0.35 * tLen);
        envelope(0.65 * tLen + 1 : tLen) = exp(t4);                  %第四段指数下降
        %合成一个乐音
        part_tone = (seriesOrgan * [sin(2 * pi * frequence(n) * t);sin(2 * pi * 2 * frequence(n) * t);...
                            sin(2 * pi * 3 * frequence(n) * t)]) .* envelope;
        part_tone = part_tone / max(part_tone);                     %归一化
        musicGUI = [musicGUI,part_tone];                              %组合各个乐音
    end
    musicGUI = musicGUI / max(musicGUI);                         %归一化
else
    for n = 1 : len
        t = linspace(0,last_time(n) - 1 / Fs,last_time(n) * Fs);
        x = linspace(0,7.5,last_time(n) * Fs);
        envelope = x./exp(x);                                                  %指数衰减的包络
         part_tone = (seriesPiano * [sin(2 * pi * frequence(n) * t);sin(2 * pi * 2 * frequence(n) * t);...
                            sin(2 * pi * 3 * frequence(n) * t);sin(2 * pi * 4 * frequence(n) * t)]) .* envelope;
        part_tone = part_tone / max(part_tone);                     %归一化
        musicGUI = [musicGUI,part_tone];                              %组合各个乐音
    end
    musicGUI = musicGUI / max(musicGUI);                         %归一化
end