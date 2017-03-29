clear all;close all;clc;
load('JpegCoeff.mat');
if ~exist('origin','var')
    origin = QTAB;
end
QTAB = origin / 2;                %将量化步长减少为原来的一半
save('JpegCoeff.mat','QTAB','ACTAB','DCTAB','origin');