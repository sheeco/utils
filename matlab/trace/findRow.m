%  rows = findRow( mat, mark_begin, mark_end )
%  eg. rows = findRow( traces, 0, 9000 )
%
%  按照给定的起始、截至标记，从矩阵中找出首列数据满足范围限制的行号。
%  mat - 给定矩阵
%  mark_begin, mark_end - 规定限定范围的起始和截至，一般为 double；0 为不做限制

function [ ret ] = findRow( mat, mark_begin, mark_end )

    rows = [];
    if( mark_begin > 0 )
        if( mark_end > mark_begin )
            rows = find( mark_begin <= mat(:,:) & mat(:,:) <= mark_end );
        else
            rows = find( mark_begin <= mat(:,:) );
        end
    else
        if( mark_end > mark_begin )
            rows = find( mat(:,:) <= mark_end );
        else
            rows = find( mat(:,:) >= 0 );
        end
    end
    
    ret = rows;

end