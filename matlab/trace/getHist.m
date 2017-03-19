%  [ info, hist_mat ] = getHist( traces, grain, normalization)
%  eg. info, mat = getHist( traces, 100, 1 )
%
%  ���ո���������߳���Ϊ��ά�������ݼ�ͳ�Ʒֲ�����
%  traces - ����ڵ�Ĺ켣���ݣ��� getTrace �����õ�
%  grain - �������㻮��ķ���߳�
%  normalization - 1 ��ʾ����Ƶ�ʾ���0 ��ʾ����Ƶ������

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