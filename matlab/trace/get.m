%  [ ans ] = get( cell, icol, opt0, opt1 )
%  eg. ans = get( cell, 3, @min, @max )
%
%  对 cell 中的所有数据，计算 opt0( opt1( 指定列 ) )

function [ ans ] = get( cell, icol, opt0, opt1 )

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

