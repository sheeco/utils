%  traces = getTrace( name_exceptions, inode, time_begin, time_end )
%  eg. traces = getTrace( 'ans,traces', 0, 0, 9000 )
%
%  �ӹ����ռ�����������У�ȡ��ָ���ڵ���ָ��ʱ�䷶Χ�ڵĹ켣���ݡ�
%  name_exceptions - Ҫ�ų����ⲻ���б����ı������ƣ��ö��ŷָ�����Ӧ�ж���ո�e.g. 'ans,info,freq'
%  inode - ��Ϊ�����ڵ�ͳ��ʱ�Ľڵ��±ꣻ0 Ϊ����ɸѡ
%  time_begin, time_end - ��ʼ������ʱ�䣻0 Ϊ����ɸѡ

function [ ret ] = getTrace( name_exceptions, inode, time_begin, time_end )

    whos = evalin('base','who');
    whos = removeException(whos, name_exceptions);
    
    traces = {};
    for i = 1:length(whos)
        
        mat = evalin('base',  whos{i} );

        rows = findRow( mat(:, 1), time_begin, time_end );
        row_begin = min(rows);
        row_end = max(rows);
        trace = mat(row_begin : row_end, :);

        if( inode <= 0 )
            traces{end+1} = trace;
        end
        if( inode > 0 && i == inode )
            traces{end+1} = trace;
        end
    end
    
    ret = traces;
end