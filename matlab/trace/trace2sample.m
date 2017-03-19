%  samples = trace2sample( traces )
%  eg. samples = trace2sample( getTrace( 'ans,traces', 0, 0, 9000 ) )
%
%  将多个节点的轨迹数据，去除时间列，并放入一个采样集。
%  traces - 多个节点的轨迹数据，从 getTrace 函数得到

function [ ret ] = trace2sample( traces )

    samples = [];
    for i = 1:length(traces)
        itrace = traces{i};
        samples = vertcat(samples, itrace(:,2:3));
    end

    ret = samples;
end