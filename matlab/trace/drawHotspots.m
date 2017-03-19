%  drawHotspots( fig, height, time_end )
%  eg. drawHotspots( drawBar( 'Statefair', 10, 20000 ) , 0, time_end )
%  
%  fig - 在 fig 图中叠加绘制热点区域；
%  height - 表示热点区域的圆形绘制的高度；
%  time_end - 绘制该时间时使用的热点集合， 0 则自动选取最新的热点集合；

function drawHotspots( fig, height, time_end )
%DRAWHOTSPOTS Summary of this function goes here
%   Detailed explanation goes here

    set(fig, 'active');
    hold on; 


    hotspots = evalin('base', 'hotspots');
    
%     % 显示范围内所有时间的热点
%     if( time_begin + time_end ~= 0 )
%         rows = find( time_begin <= hotspots(:,1) & hotspots(:,1) <= time_end);
%     else
%         rows = find( hotspots(:,1) );
%     end

    % 只显示范围内的最后一轮热点
    if( time_end ~= 0 )
        time_end = floor( time_end / 900 ) * 900;
        rows = find( hotspots(:,1) == time_end );
    else
        rows = find( hotspots(:,1) == max(hotspots(:,1)) );
    end
    row_start = min(rows);
    row_end = max(rows);

    for j = row_start : row_end
        alpha = 0 : pi / 50 : 2 * pi;  %角度 [ 0, 2 * pi ] 
        heights = zeros(1, length(alpha) );
        R = 100;  %半径 
        x = R * cos( alpha ) + hotspots(j, 2); 
        y = R * sin( alpha ) + hotspots(j, 3); 
        plot3(x, y, heights, '--', 'color', [ 0.24 0.57 0.25 ], 'LineWidth', 2);
        heights = heights + height;
        plot3(x, y, heights, '--', 'color', [ 0.24 0.57 0.25 ], 'LineWidth', 2);
        hold on;
    end


%     axis equal;
    hold off;

end

