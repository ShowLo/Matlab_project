function add(row,col,isFace)
%输入参数
%row：块的行索引
%col：块的列索引
%isFace：记录块是否属于人脸区域的矩阵

%这些全局变量和主函数的一样，用以数据传递共享
global up down left right count added;
[H,W] = size(isFace);
added(row,col) = 1;             %将当前块标记为已加入当前人脸区域
count = count + 1;              %加入的块总数加一
if row < up                          %加入的块成为新的最上边的块，更新数据
    up = row;
end
if row > down                     %加入的块成为新的最下边的块，更新数据
    down = row;
end
if col < left                          %加入的块成为新的最左边的块，更新数据
    left = col;
end
if col > right                        %加入的块成为新的最右边的块，更新数据
    right = col;
end
%当前块的上边的块如果存在，也属于人脸区域而且未加入，将其加进来
if row - 1 > 0 && isFace(row - 1,col) && ~added(row - 1,col) 
    add(row - 1,col,isFace);
end
%当前块的下边的块如果存在，也属于人脸区域而且未加入，将其加进来
if row + 1 <= H && isFace(row + 1,col) && ~added(row + 1,col) 
    add(row + 1,col,isFace);
end
%当前块的左边的块如果存在，也属于人脸区域而且未加入，将其加进来
if col - 1 > 0 && isFace(row,col - 1) && ~added(row,col - 1) 
    add(row,col - 1,isFace);
end
%当前块的右边的块如果存在，也属于人脸区域而且未加入，将其加进来
if col + 1 <= W && isFace(row,col + 1) && ~added(row,col + 1) 
    add(row,col + 1,isFace);
end