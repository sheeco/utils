%  [ info, hist_mat ] = getHist( traces, grain, normalization)
%  eg. info, mat = getHist( traces, 100, 1 )
%
%  按照给定的网格边长，为二维采样数据集统计分布矩阵。
%  traces - 多个节点的轨迹数据，从 getTrace 函数得到
%  grain - 将采样点划入的方格边长
%  normalization - 1 表示返回频率矩阵；0 表示返回频数矩阵

function [ info, hist_mat ] = getHist( traces, grain, normalization)
%   Detailed explanation goes here

    samples = trace2sample( traces );

    range = num2cell(range);
    [floor_x, ceil_x, floor_y, ceil_y] = range{:};

    floor_x = floor( floor_x / grain ) * grain;
    ceil_x = ceil( ceil_x / grain ) * grain;
    floor_y = floor(floor_y / grain ) * grain;
    ceil_y = ceil( ceil_y / grain ) * grain;
    edge_x = floor_x : grain : ceil_x;
    edge_y = floor_y : grain : ceil_y;

    Z = hist3(samples, 'edge', { edge_x, edge_y }, 'FaceColor', [0.80, 0.20, 0], 'EdgeColor', [1, 1, 1], 'FaceAlpha', 0.3);
    % normalization means devide it by length of data_x (or data_y)
    hist_mat = Z'; 
	if(normalization > 0)
		hist_mat = Z' / length(samples(:,1)); 
	end

    white = [1 1 1];
    black = [0 0 0];
    grey = [0.75 0.75 0.75];
    red = [1 0 0];
    yellow = [1 1 0];
    blue = [0 0 1];
    
    info = [];
    info(1) = floor_x;
    info(2) = floor_y;
    info(3) = grain;
    
end