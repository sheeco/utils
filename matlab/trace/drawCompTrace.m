%  drawCompTrace( vars, time_begin, time_end, sub_plot )
%  eg. drawCompTrace( vars, 0, 0, 1 )
%
%  vars - Ҫ���б����ı������ƣ����� getVars('') �õ�
%  inode - ��Ϊ�����ڵ�ͳ��ʱ�Ľڵ��±ꣻ0 Ϊ����ɸѡ
%  time_begin, time_end - ��ʼ������ʱ�䣻0 Ϊ����ɸѡ
%  sub_plot - �Ƿ�ʹ�� subplot ��ʾ��� figure

function drawCompTrace( vars, time_begin, time_end, sub_plot )

    traces = {};
    comparisons = {};
    
    for ivar = 1:length(vars)
        
        model = evalin('base', vars{ivar});

        column_time = model(:, 1);
        comparison = {};
        
        num_node = (size(model, 2) - 1) / 4;
        num_node = floor(num_node);
        for inode = 1:num_node
            icolumns_prediction = (inode - 1) * 4 + 2;
            icolumns_prediction = icolumns_prediction : icolumns_prediction + 1;
            icolumns_fact = icolumns_prediction(end) + 1 : icolumns_prediction(end) + 2;

            columns_prediction = model(:, icolumns_prediction);
            columns_fact = model(:, icolumns_fact);
            trace_prediction = horzcat(column_time, columns_prediction);
            trace_fact = horzcat(column_time, columns_fact);
        
            % collect all the traces to for motion range computation
            traces{end + 1} = trace_prediction;
            traces{end + 1} = trace_fact;

            % clip according to time limit
        
            rows = findRow( model(:, 1), time_begin, time_end );
            irow_begin = min(rows);
            irow_end = max(rows);

            trace_prediction_clipped = trace_prediction(irow_begin : irow_end, :);
            trace_fact_clipped = trace_fact(irow_begin : irow_end, :);
            comparison{end + 1} = trace_prediction_clipped;
            comparison{end + 1} = trace_fact_clipped;
        end                
        
        comparisons{end + 1} = comparison;
        
    end
        
    % draw a trace comparison for each var
    
    if sub_plot
        figure();
    end
    
    for ivar = 1:length(comparisons)
        
        comparison = comparisons{ivar};
        
        var = vars{ivar};
        varname = makeName(var, 0);
        name = strcat(varname, '-time(', int2str(time_begin), ',', int2str(time_end), ')');
        
        if sub_plot
            subplot(length(vars), 1, ivar);
        else
            figure()
        end
        set(gcf, 'outerposition', get(0, 'screensize'), 'name', name);
            
%         red = [1 0 0];
%         green = [0 0.5 0];
        colors = colormap(lines);
        
        num_node = length(comparison) / 2;
        num_node = floor(num_node);
        for inode = 1:num_node
            iprediction = (inode - 1) * 2 + 1;
            ifact = iprediction + 1;
        
            prediction = comparison{iprediction};
            fact = comparison{ifact};
        
            color = colors(mod(inode, length(colors)) + 1, :);
 
%             plot(prediction(:,2), prediction(:,3), '-. .', 'color', red);
            plot(prediction(:,2), prediction(:,3), '-. .', 'color', color);
            hold on;
%             plot(fact(:,2), fact(:,3), '- .', 'color', green);
            plot(fact(:,2), fact(:,3), '- .', 'color', color);
            title(name);
            
        end
        
        legends = {};
        for inode = 1:num_node
            legends{end+1} = ['node', num2str(inode), '-prediction'];
            legends{end+1} = ['node', num2str(inode), '-fact'];
        end
        legend(legends, 'Location', 'NorthWest');
%         motion_range = getRange(traces{i}, 100);
        motion_range = getRange(traces, 100);
        axis(motion_range);
    end
    

end

%  names = horzcat(x1(1:200,2:3),x2(1:200,2:3),x3(1:200,2:3))

%  temp = x1(1:end,2);
%  temp = horzcat(temp, x1(1:end,3));

% CTRL + R/T  to Comment / UnComment

% NameSource=[10 20 30];
% for i=1:3
%     Name=['VarName',num2str(i)];
%     eval([Name,'=NameSource(i)'])
% end;
% 
% VarName1 =
%      10
% 
% VarName2 =
%      20
% 
% VarName3 =
%      30

% v = evalin('base', 'var'); %�ѻ��������ռ��еı���var��ֵ�����ֲ�����v��
% 
% v = evalin('base', 'who'); %��ѯ���������ռ��еı������ƣ����ѱ������Ʊ��浽v�����У����������û��������ռ��еı������ڽ����ϻ���ͼ�Ρ�
