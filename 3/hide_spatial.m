function image_hide = hide_spatial(image,str)
%输入参数
%image：用来隐藏信息的图像
%str：要隐藏的信息
%输出参数
%image_hide：经过处理后隐藏了信息的图像
[Height,Width] = size(image);                      %获取用来隐藏信息的图像的大小
bitNum = 7;                                                %根据ASCII码的数值范围，用7比特存储每个字符
maxLenBit = floor(log2(Height * Width));     %隐藏的信息最多可以有2^maxLenBit比特
num = uint8(str);                                          %先将待隐藏信息从字符串转为数字
bin = de2bi(num,bitNum);                            %再转为二进制码
streamLen = length(num) * bitNum;             %计算二进制码的长度
if streamLen + maxLenBit > Height * Width  %检查是否超出范围
    error('隐藏信息数过多，超过容量');
end
%二进制码流，头部的maxLenBit位存储的是信息长度信息
binStream = [de2bi(streamLen,maxLenBit)';reshape(bin',[streamLen,1])];
image_bin = de2bi(image);
%将二进制码流依次存储到各像素分量的最低位
image_bin(1 : maxLenBit + streamLen,1) = binStream;
%转回jpg图像，至此信息隐藏完成
image_hide = reshape(bi2de(image_bin),[Height,Width]);