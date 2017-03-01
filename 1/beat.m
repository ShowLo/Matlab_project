function beatNum = beat(dotNum,Fs)
%输入参数
%dotNum：样点数
%Fs：采样频率
%输出参数
%beatNum：节拍数
beat_4 = Fs / (2 * 4);                %1/4拍的样点数
beatNum = round(dotNum / beat_4);