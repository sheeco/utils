%  [ vars_filtered ] = filterTrace( vars, speed )
%  eg. vars_filtered = drawCompTrace( {'n31', 'n32'}, 10 )
%
%  vars - 要进行遍历的变量名称，可由 getVars('') 得到
%  speed - 速度(米/秒)上限

function [ vars_filtered ] = filterTrace( vars, speed )

    vars_filtered = {};
    
    for i = 1:length(vars)
        
        model = evalin('base', vars{i});
        
        rows = [];
        result = [];
        
        for irowTo = 1:size(model, 1)
            if isempty(rows)
                rows = model(irowTo, :);
                continue
            end
            
            rowTo = model(irowTo, :);
            duration = rowTo(:, 1) - rows(end, 1);
            differences = rowTo(1, end-1:end) - rows(end, end-1:end);
            distance = (differences(1, 1)^2 + differences(1, 2)^2)^(1/2);
            
            if (distance / duration) < speed
                rows(end+1, :) = rowTo;
            else
                % push slow points into result
                if size(rows, 1) > 1
                    result = vertcat(result, rows);
                else
                    % single point means fast passing by
                    % should throw away
                end
                rows = rowTo;
            end
        end

        % deal with left rows
        if size(rows, 1) > 1
            result = vertcat(result, rows);
        end
        
        vars_filtered{end+1} = strcat(vars{i}, '_speed', num2str(speed));
        assignin('base', vars_filtered{end}, result);

    end
end
