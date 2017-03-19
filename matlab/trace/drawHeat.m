%  drawHeat( name, grain, heat )
%  eg. drawHeat( 'Orlando', 10, 0.02 )
%
%  name - 图表标题
%  grain - 将采样点划入的方格边长；
%  heat - 映射到颜色表顶端的频数 $heat * max-count ，高于该频数的方格都将以顶端颜色显示；

function [fig] = drawHeat( name, grain, heat )
%DISPLAYHEAT Summary of this function goes here
%   Detailed explanation goes here

figure('outerposition',get(0,'screensize'), 'name', strcat( name, '-', num2str(grain), '-', num2str(heat) ) );
axis equal;

coor = [];
datas = evalin('base','who');
num = length(datas);

for i = 1:num
    if( ~ strcmp( datas{i}, 'hotspots') ) 
        data = evalin('base',  datas{i} );
        coor = vertcat(coor, data(:, 2:3));
    end
end
%     assignin('base', 'coor', coor);

    down_x = floor( min(coor(:,1)) / grain ) * grain;
    up_x = ceil( max(coor(:,1)) / grain ) * grain;
    down_y = floor( min(coor(:,2)) / grain ) * grain;
    up_y = ceil( max(coor(:,2)) / grain ) * grain;
    edge_x = down_x : grain : up_x;
    edge_y = down_y : grain : up_y;

    [COUNT COOR] = hist3(coor, 'edge', { edge_x, edge_y });
    COUNT = COUNT';
     
    COUNT_COUNT = imresize(COUNT, 1);  % k > 1 时，将图像扩大 k 倍，中间像素插值
    imagesc(COOR{1}, COOR{2}, COUNT_COUNT);
    axis xy
    
    colormap(hot);
    colorbar;
    
    max_count = max( max(COUNT) );
    up_axis = ceil(max_count * heat);
%     up_axis = max([up_axis ( num / 3)]);
%     up_axis = heat;
    caxis([0, up_axis]);
    
    fig = gcf;
end

