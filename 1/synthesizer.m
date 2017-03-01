%第11题，利用前面得到的每个音调对应的傅里叶级数合成《东方红》
clear all;close all;clc;
load('info.mat');

len = length(info);
harmonicsNum = length(info(1).harmonicsAmpli);  %谐波级次
standardName = {'F-';'bG-';'G-';'bA';'A';'bB';'B';'C';'bD';'D';'bE';'E';'F';'bG';'G';...
                           'bA+';'A+';'bB+';'B+';'C+';'bD+';'D+';'bE+';'E+'};
nameNum = length(standardName);                      %标准音个数
%各次谐波的信息
harmonicsInfo = struct('tuneName','','harmonicsAmpli','','exit','');

for num = 1 : nameNum
    ampli = zeros(1,harmonicsNum);
    total = 0;                                                            %找到的某个音的总数
    for index = 1 : len
        %找到某个音，对所有找到的音的同次谐波幅度求和后取平均作为这个音的谐波幅度
        if strcmp(standardName{num},info(index).tuneName)
           ampli = ampli + info(index).harmonicsAmpli;
           total = total + 1;                                         %找到一个音，总数加一
        end
    end
    if total > 0
        ampli = ampli / total;
        harmonicsInfo(num).exit = true;                     %存在这个音
    else
        harmonicsInfo(num).exit = false;                    %不存在这个音
    end
    %保存音调名和各次谐波幅度
    harmonicsInfo(num).tuneName = standardName{num};
    harmonicsInfo(num).harmonicsAmpli = ampli;
end

freq_sample = 8000;                     %采样频率
T = 1/freq_sample;                       %采样周期
beatNum = 2;                              %每小节的拍数
barNum = 4;                                %小节数
beatTime = 0.5;                           %每小拍的时间

%在F-调下各个音的频率（将原曲降了八度）
freq_6_octave_below = 293.66;    %低八度的6
freq_1 = 349.23;
freq_2 = 392;
freq_5 = 523.25;
freq_6 = 587.33;
freq = [freq_5;freq_5;freq_6;freq_2;freq_1;freq_1;freq_6_octave_below;freq_2] / 2;

%各个音的持续时间
last_time = beatTime * [1;1/2;1/2;2;1;1/2;1/2;2];
%傅里叶级数
series = zeros(length(freq),harmonicsNum);
%降八度后的音调名，找不到D-故用F-代替
%tune = ['C';'C';'D';'G-';'F-';'F-';'D-';'G-'];
tune = {'C';'C';'D';'G-';'F-';'F-';'F-';'G-'};
%找出某个音调的各次谐波分量的幅度
for n = 1 : length(tune)
    for m = 1 : nameNum
        if (strcmp(tune{n},harmonicsInfo(m).tuneName))
            if (harmonicsInfo(m).exit)  %找到了这个音而且这个音存在
                series(n,:) = harmonicsInfo(m).harmonicsAmpli;
                break;
            else                                  %这个音不存在，改为这个音的下个音
                [bool,index] = ismember(tune{n},standardName);
                tune{n} = standardName{index + 1}; 
            end
        end
    end
end
%用一系列乐音信号拼出一个片段
tonePlay = [];
for n = 1 : length(freq)
    %先把某个乐音合成并归一化然后再将这些乐音组合起来
    temp = toneSynthesizer(freq_sample,freq(n),last_time(n),series(n,:));
    temp = temp / max(temp); 
    tonePlay = [tonePlay,temp];
end
%归一化
tonePlay = tonePlay/max(abs(tonePlay));
%播放
sound(tonePlay,freq_sample);