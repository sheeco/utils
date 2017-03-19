%  [ floor_x, ceil_x, floor_y, ceil_y ] = getRange( traces, grain )
%  eg. r = getRange( traces, 1 )
%
%  为给定的节点轨迹数据集统计运动范围，并修整到给定粒度。
%  traces - 1xN cell
%  grain - 修整到粒度，e.g. 1, 100, ...

function [ ret ] = getRange( traces, grain )
%   Detailed explanation goes here

    samples = trace2sample( traces );

    floor_x = floor( min(samples(:,1)) / grain ) * grain;
    ceil_x = ceil( max(samples(:,1)) / grain ) * grain;
    floor_y = floor( min(samples(:,2)) / grain ) * grain;
    ceil_y = ceil( max(samples(:,2)) / grain ) * grain;

    ret = [floor_x ceil_x floor_y ceil_y];
    
end

