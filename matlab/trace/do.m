%  [ ans ] = do( cell, icol, opt0, opt1 )
%  eg. ans = do( cell, 3, @min, @max )
%
%  �� cell �е��������ݣ����� opt0( opt1( ָ���� ) )

function [ ans ] = do( cell, icol, opt0, opt1 )

    for i = 1 : length(cell)

            data = cell{i};
            val = opt1(data(:,icol));
            if( i == 1)
                ans = val;
            else
                ans = opt0(ans, val);
            end
        end
    end

end

