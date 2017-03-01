clear all;close all;clc;
load('v.mat');
len = 8;                                  %分块大小
threshold = 0.55;                   %阈值
L = 3;
switch L                                 %根据L选择相应的人脸标准
    case 3
        v = v_3;
    case 4
        v = v_4;
    case 5
        v = v_5;
end
group = imread('group.jpg');  %用来检测人脸的图像

%第三题的(a)--顺时针旋转90度
group = imrotate(group,-90);
%第三题的(b)--保持高度不变，宽度拉伸为原来两倍
%group = imresize(group,[length(group(:,1,1)),2 * length(group(1,:,1))]);
%第三题的(c)--适当改变颜色
%group = imadjust(group,[0.1,0.5,0.3;0.4,1,0.9],[]);

[H,W,~] = size(group);
row = floor(H / len);               %分块后的纵向分块数，不整除时忽略最下边的图像
col = floor(W / len);               %分块后的横向分块数，不整除时忽略最右边的图像
d = zeros(row,col);
for r = 1 : row                        %遍历所有块，得到与人脸标准的距离
    for c = 1 : col
        feature = getFeature(group(len * (r - 1) + 1 : len * r,len * (c - 1) + 1 : len * c,:),L);
        d(r,c) = getDistance(feature,v);
    end
end
isFace = d < threshold;          %找出那些在阈值内的图像
redFrame = ones(size(group));%用来存储红框的信息
w = 2;                                    %红框线的线宽
%定义这些全局变量以和add函数进行数据传递共享
global up down left right count added;
added = zeros(row,col);          %记录某个块是否已加入某个人脸区域
for r = 1 : row
    for c = 1 : col
        %只有当这个块符合人脸标准并且未加入某个人脸区域时才进行下面操作
        if isFace(r,c) && ~added(r,c)
            count = 0;                  %记录符合条件的块总数
            up = r;                        %记录人脸区域最上的块行索引
            down = r;                   %记录人脸区域最下面的块行索引
            left = c;                      %记录人脸区域最左的块列索引
            right = c;                    %记录人脸区域最右的块列索引
            add(r,c,isFace);            %将这个块加入当前人脸区域
            added(up : down,left : right) = 1; %将整个矩形区域标记已加入当前人脸区域
            
            %第三题的(b)要将此处判断条件改为if count > 10
            if count > 8                 %只有符合条件的块总数大于一定值才认为检测到人脸，并生成初始红框矩阵
                redFrame((up - 1) * len + 1 : (up - 1) * len + w,(left - 1) * len + 1 : right * len,:) = 0;
                redFrame(down * len - w + 1 : down * len,(left - 1) * len + 1 : right * len,:) = 0;
                redFrame((up - 1) * len + 1 : down * len,(left - 1) * len + 1 : (left - 1) * len + w,:) = 0;
                redFrame((up - 1) * len + 1 : down * len,right * len - w + 1 : right * len,:) = 0;
            end
        end
    end
end
redFrame(:,:,1) = ~redFrame(:,:,1) * 254 + 1; %这里真正生成后面要用到的红框矩阵
redFrame = uint8(redFrame);
group = group.*redFrame;