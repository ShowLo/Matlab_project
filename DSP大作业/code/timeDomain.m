clear;close all;clc;
tic;
load('BD_Code.mat');
extension = 5;                                                     %PRN序列点延拓数
PRNLen = 2046 * extension;                               %经过延拓PRN序列得到的重构方波信号的长度

fid = fopen('UEQ_rawFile_int16.dat','r');
dataLen_1ms = 10e6 / 1e3;                                %1ms时间长度的采样点
timeLen =  2;                                                      %取出的采样点的时间长度
dataLen = dataLen_1ms * timeLen;                     %取出的采样点总数

[data,~] = fread(fid,dataLen,'int16');                  %读出采样点数据
r = resample(data,PRNLen,dataLen_1ms)';         %对采样点重采样使其单位长度与延拓后的PRN相适

threshold = 8;                                                    %判断是否匹配成功的阈值
satelliteNum = 37;                                              %卫星个数
result = [];
for n = 1 : satelliteNum                                      %对所有卫星的PRN均做匹配滤波即相关处理
    %重整PRN序列，每个点均延拓extension个，以重构成方波序列
    bdCode = reshape(repmat(BD_Code(n,:),extension,1),1,PRNLen);
    corr = conv(r,fliplr(bdCode));                         %作相关，这里用卷积代替相关
    if(max(corr)/threshold > mean(abs(corr)))     %判断是否匹配成功
        result = [result;n];                                       %记录匹配成功的卫星编号
    end
end
toc;