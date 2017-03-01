function [musicGUI,last_time,Fs] = getMusic(handles)
%输入参数
%handles：句柄
%输出参数
%musicGUI：合成的音乐
%last_time：各个乐音的时间长度
%Fs：采样频率

%获取简谱输入和节拍数输入
a = get(handles.notation,'String');
b = get(handles.beatNum,'String');
f = get(handles.sampleFreq,'String');
%检查输入是否正确
if isempty(a) || isempty(b) || isempty(f)
    %若有输入为空则弹出错误警告窗口
    h1 = errordlg('请检查输入，确保输入不为空','警告','modal');
else
    %获取曲调
    tune = get(handles.tune,'value');
    times = [0;2;-9;-7;-5;-4;-2];                       %各个调与A调的音程关系
    realTune = times(tune);
    
    %获取乐器
    instru = get(handles.instrument,'value');
    instruName = {'吉他';'风琴';'钢琴'};
    instrument = instruName{instru};
    
    %获取升降调信息
    rft = get(handles.rise_fall_tune,'value');
    rftInfo = [2;1;0.5];
    rise_fall_tune = rftInfo(rft);
    
    %获取播放速度
    speed = get(handles.playSpeed,'value');
    speedMulpti = [1;2;4];
    playSpeed = speedMulpti(speed);
    
    %获取采样频率
    Fs = str2num(f);
    
    %以空格分隔字符串然后获取节拍数信息
    inputBeatNum = textscan(b,'%s ');
    inputBeatNum = inputBeatNum{1};
    len = length(inputBeatNum);
    for n = 1 : len
        beatNum(n) = str2num(inputBeatNum{n});
    end
    
    %以空格分隔字符串然后获取简谱信息
    inputNotation = textscan(a,'%s ');
    notation = inputNotation{1};
    notationLen = length(notation);                           %简谱长度
    for n = 1 : notationLen
        if strcmp(notation{n}(1),'+')                               %高八度的音
            temp = notation{n}(2:end);
            notationPlay(n) = str2num(temp) + 14;
        elseif strcmp(notation{n}(1),'-')                          %减八度的音
            temp = notation{n}(2:end);
            notationPlay(n) = str2num(temp);
        else                                                                  %正常音
            notationPlay(n) = str2num(notation{n}) + 7;
        end
    end
    
    n = [-12;-10;-8;-7;-5;-3;-1;0;2;4;5;7;9;11;12;14;16;17;19;21;23];
    base = 2 ^ (1 / 12);
    FreqNotation = 440 * base .^ n;                           %A调下从减八度的1到高八度的7的频率
    
    if len ~= notationLen
        h = errordlg('请确认简谱和节拍数是否匹配','警告','modal');
    else
        %组装乐曲
        quarterTime = 0.5 / 4;                                      %1/4拍的时间
        frequence = FreqNotation(notationPlay);         %A调下乐曲各个乐音的频率
        frequence = frequence * base^realTune;         %真实调下的频率
        frequence = frequence * rise_fall_tune;            %升降调后的频率
        last_time = quarterTime * beatNum;                %乐曲各个乐音的时间
        last_time = last_time / playSpeed;                    %变速之后的时间
        musicGUI = music(frequence,last_time,Fs,instrument);
    end
end