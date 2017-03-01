function d = getDistance(u,v)
%输入参数
%u：矢量
%v：矢量
%输出参数
%d：距离
p = sqrt(u.*v);
d = 1 - sum(p);