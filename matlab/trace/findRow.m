%  rows = findRow( mat, mark_begin, mark_end )
%  eg. rows = findRow( traces, 0, 9000 )
%
%  ���ո�������ʼ��������ǣ��Ӿ������ҳ������������㷶Χ���Ƶ��кš�
%  mat - ��������
%  mark_begin, mark_end - �涨�޶���Χ����ʼ�ͽ�����һ��Ϊ double��0 Ϊ��������

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