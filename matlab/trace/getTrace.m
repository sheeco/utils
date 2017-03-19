%  traces = getTrace( name_exceptions, inode, time_begin, time_end )
%  eg. traces = getTrace( 'ans,traces', 0, 0, 9000 )
%
%  从工作空间的所有数据中，取出指定节点在指定时间范围内的轨迹数据。
%  name_exceptions - 要排除在外不进行遍历的变量名称，用逗号分隔，不应有多余空格，e.g. 'ans,info,freq'
%  inode - 仅为单个节点统计时的节点下标；0 为不做筛选
%  time_begin, time_end - 起始、截至时间；0 为不做筛选

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