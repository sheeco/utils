%  [ fig ] = drawHist( traces, title, grain, grain_tick, range, normalization )
%  eg. drawHist( traces, 'demo', 100, 1000, [-10000, -15000, 10000, 5000], 1 )
%
%  按照给定的方格边长，为轨迹数据集统计并绘制三维频数直方图。
%  traces - 多个节点的轨迹数据，从 getTrace 函数得到
%  title - 图表标题
%  grain - 将采样点划入的方格边长
%  grain_tick - 必须手动指示 y 轴的刻度，e.g. 500, 2000, 5000, ...
%  range - 绘制区域的边界，单位为米，可通过 range 函数获取，e.g. [-10000, -15000, 10000, 5000]
%  normalization - 1 表示返回频率矩阵；0 表示返回频数矩阵

function [ ret ] = drawHist( traces, title, grain, grain_tick, range, normalization )
%   Detailed explanation goes here

    samples = trace2sample( traces );

%     grid_x = ceil( (max(samples_nodes(:,1)) - min(samples_nodes(:,1))) / grain );
%     grid_y = ceil( (max(samples_nodes(:,2)) - min(samples_nodes(:,2))) / grain );

    range = num2cell(range);
    [floor_x, ceil_x, floor_y, ceil_y] = range{:};

    floor_x = floor( floor_x / grain ) * grain;
    ceil_x = ceil( ceil_x / grain ) * grain;
    floor_y = floor(floor_y / grain ) * grain;
    ceil_y = ceil( ceil_y / grain ) * grain;
    edge_x = floor_x : grain : ceil_x;
    edge_y = floor_y : grain : ceil_y;

    figure('outerposition',get(0,'screensize'), 'name', strcat( title, '-', num2str(grain) ) );
    axis equal;
    axis([floor_x, ceil_x, floor_y, ceil_y]);

    Z = hist3(samples, 'edge', { edge_x, edge_y }, 'FaceColor', [0.80, 0.20, 0], 'EdgeColor', [1, 1, 1], 'FaceAlpha', 0.3);
    % normalization means devide it by length of data_x (or data_y)
    hist_mat = Z'; 
	if(normalization > 0)
		hist_mat = Z' / length(samples(:,1)); 
	end
    % important for "surf" - makes defined grid    
    [X, Y] = meshgrid(edge_x, edge_y);
%     surf(X, Y, Z');

    white = [1 1 1];
    black = [0 0 0];
    grey = [0.75 0.75 0.75];
    red = [1 0 0];
    yellow = [1 1 0];
    blue = [0 0 1];
    
    low = grey;
    high = black;
    max_freq = max(max(hist_mat));
    color_map = zeros(length(edge_y), length(edge_x), 3);
    for i = 1:length(edge_y)
        for j = 1:length(edge_x)
            if hist_mat(i, j) == 0
                color_map(i, j, :) = [1 1 1];
            else
                rank = hist_mat(i, j) / max_freq;
                color_map(i, j, :) = (1 - rank) * low + rank * high;
            end
        end
    end
    
    fig = bar3c(edge_y, hist_mat, color_map);
    len_color_bar = 100;
    color_bar = zeros(len_color_bar, 3);
    for i = 1:len_color_bar
        rank = i / len_color_bar;
        color_bar(i,:) = rank * high + (1 - rank) * low;
    end
    colormap(color_bar); 
    colorbar;
    caxis([0, 0.02 * ceil(max_freq / 0.02)]);
    set(fig, 'EdgeColor', 'none');
    set(fig, 'FaceAlpha', 0.5);
%     set(fig, 'EdgeColor', low);
    
    xlabel('X坐标(米)');
    ylabel('Y坐标(米)');
    zlabel('轨迹采样点频率');
    
%     % 线条注释,多条的话: legend('xxx','xxx2','xxx3'）
%     legend('xxx'); 
%     % x轴的绘制范围
%     xlim([2, 46]);
%     % 对x，y轴的上限与下限绘制范围一起做控制，但是间隔还是要用上面的set来改
%     % axis([xmin, xmax, ymin, ymax])
%     axis([2,46,0,2]) 

    step_tick = grain_tick / grain;
    floor_label = ceil(floor_x / grain_tick) * grain_tick;
    floor_tick = (floor_label - floor_x) / grain + 1;
    ceil_label = floor(ceil_x / grain_tick) * grain_tick;
    ceil_tick = (ceil_label - floor_x) / grain + 1;
    set(gca,'XTick', [floor_tick: step_tick: ceil_tick]);
    set(gca,'xticklabel', [floor_label: grain_tick: ceil_label]);

    set(gcf, 'renderer', 'opengl');
    ret = gcf;
%     ret = [size(X), size(Y), size(hist_mat)];
%     ret = [length(edge_x), length(edge_y), shape(1), shape(2)];
%     ret = color_map;
    
end

