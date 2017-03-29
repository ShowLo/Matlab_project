clear all;close all;clc;
[fmt,Fs] = audioread('fmt.wav');
T = 1 / Fs;                                         %采样周期
len = length(fmt);                             %采样点重总数
t = 0 : T : len / Fs - T;                        %时域
hold on;
plot(t,fmt);
[b,a] = butter(10,[80 / (Fs / 2) , 2000 / (Fs / 2)]);
fmt = filter(b,a,fmt);
plot(t,fmt + 0 ,'r');
absFmt = abs(fmt);

% y = medfilt1(absFmt,700);
% y = medfilt1(y,700);
% y = medfilt1(y,700);
% y = smooth(y);
% m = max(y);
% y =  m - y;
% 
% [pks,id]=findpeaks(y,'minpeakdistance',1000);
% f(id)=1;
% f(length(y))=1;
% % idMin = find(diff(sign(diff(y)))>0)+1;
% % f(idMin) =1;
% % f(length(y))=1;
% 
% T = 1 / Fs;                                         %采样周期
% len = length(fmt);                             %采样点重总数
% t = 0 : T : len / Fs - T;                        %时域
% plot(t,fmt);
% hold on;
% plot(t,y,'g');
% hold on;
% plot(t,f,'r');