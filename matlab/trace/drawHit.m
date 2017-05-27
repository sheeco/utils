%  drawHit( vars, limit, sub_plot )
%  eg. drawHit( vars, 100, 1 )
%
%  vars - 要进行遍历的变量名称，可由 getVars('') 得到
%  limit - 界定是否命中的阈值
%  sub_plot - 是否使用 subplot 显示多个 figure

function drawHit( vars, limit, sub_plot )

%     for i = 1:length(vars)
%         
%         model = evalin('base', vars{i});
% 
%         column_time = model(:, 1);
%         columns_prediction = model(:, 2:3);
%         columns_fact = model(:, 4:5);
%         columns_difference = columns_prediction - columns_fact;
%         column_deviation = (columns_difference(:, 1).^2 + columns_difference(:, 2).^2).^(1/2);
%         deviations = vertcat(deviations, column_deviation);
%         
%     end
    if sub_plot
        figure();
    end
    
    for ivar = 1:length(vars)
        var = vars{ivar};
        model = evalin('base', var);

        num_node = (size(model, 2) - 1) / 4;
        num_node = floor(num_node);
        deviations = [];
        
        for inode = 1:num_node
            icolumns_prediction = (inode - 1) * 4 + 2;
            icolumns_prediction = icolumns_prediction : icolumns_prediction + 1;
            icolumns_fact = icolumns_prediction(end) + 1 : icolumns_prediction(end) + 2;

            columns_prediction = model(:, icolumns_prediction);
            columns_fact = model(:, icolumns_fact);

            columns_difference = columns_prediction - columns_fact;
            column_deviation = (columns_difference(:, 1).^2 + columns_difference(:, 2).^2).^(1/2);
            deviations = vertcat(deviations, column_deviation);
        end
        
        rows_hit = find( deviations <= limit );
        num_hit = length(rows_hit);
        num_all = length(deviations);
            
        hit_rate = num_hit / num_all;
        hit_rate = num2str(hit_rate);

        max_ = max(deviations);
        max_tick = ceil(max_ / limit) + 1;
        ceil_ = max_tick * limit;

        edges = 0:limit:ceil_;
        N = histc(deviations, edges);
        N = N / num_all;

        varname = makeName(var, 0);
        name = strcat(varname, '-hitrate', hit_rate);
        if sub_plot
            subplot(length(vars), 1, ivar);
        else
            figure();
        end
        set(gcf, 'outerposition', get(0, 'screensize'), 'name', name);
        bar(N);
        title(name);

        set(gca, 'xLim', [0, max_tick]);
        set(gca, 'xTick', [0:1:max_tick]);
        ticks = {''};
        for i = 2:length(edges) - 1
            ticks{end+1} = num2str(edges(i));
        end
        ticks{end+1} = '';
        set(gca, 'xTickLabel', ticks);

%         for i = 1:length(N) 
%             text(i, N(i), num2str(N(i)), 'FontSize', 8, 'horiz','center','vert','top') 
%         end
    
    end
end
