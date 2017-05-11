%  traces = getTrace( name_exceptions, inode, time_begin, time_end )
%  eg. traces = getTrace( 'ans,traces', 0, 0, 9000 )
%
%  �ӹ����ռ�����������У�ȡ��ָ���ڵ���ָ��ʱ�䷶Χ�ڵĹ켣���ݡ�
%  vars - Ҫ���б����ı������ƣ����� getVars('') �õ�
%  inode - ��Ϊ�����ڵ�ͳ��ʱ�Ľڵ��±ꣻ0 Ϊ����ɸѡ
%  time_begin, time_end - ��ʼ������ʱ�䣻0 Ϊ����ɸѡ

function [ ret ] = getTrace( vars, inode, time_begin, time_end )

    traces = {};
    for i = 1:length(vars)
        
        mat = evalin('base',  vars{i} );

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