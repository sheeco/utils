%  samples = trace2sample( traces )
%  eg. samples = trace2sample( getTrace( 'ans,traces', 0, 0, 9000 ) )
%
%  ������ڵ�Ĺ켣���ݣ�ȥ��ʱ���У�������һ����������
%  traces - ����ڵ�Ĺ켣���ݣ��� getTrace �����õ�

function [ ret ] = trace2sample( traces )

    samples = [];
    for i = 1:length(traces)
        itrace = traces{i};
        samples = vertcat(samples, itrace(:,2:3));
    end

    ret = samples;
end