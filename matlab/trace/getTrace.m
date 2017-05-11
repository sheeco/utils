%  traces = getTrace( name_exceptions, inode, time_begin, time_end )
%  eg. traces = getTrace( 'ans,traces', 0, 0, 9000 )
%
%  从工作空间的所有数据中，取出指定节点在指定时间范围内的轨迹数据。
%  vars - 要进行遍历的变量名称，可由 getVars('') 得到
%  inode - 仅为单个节点统计时的节点下标；0 为不做筛选
%  time_begin, time_end - 起始、截至时间；0 为不做筛选

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