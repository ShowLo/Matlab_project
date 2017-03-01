function u = getFeature(image,L)
%输入参数
%image：图像三维矩阵
%L：2^(3*L)种颜色
%输出参数
%u：特征矢量
[H,W,~] = size(image);
image = floor(double(image) / 2^(8 - L));  %保证RGB系数的范围在0到2^L - 1之间
                                                                %计算c，这里加1是为了保证最小值是1而不是0
c = image(:,:,1) * 2^(2 * L) + image(:,:,2) * 2^L + image(:,:,3) + 1;
u = zeros(2^(3 * L),1);
for n = 1 : 2^(3 * L)
    u(n) = sum(sum(c == n));                      %统计某个颜色出现次数
end
u = u / (H * W);                                         %计算频率