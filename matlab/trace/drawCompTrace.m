%  drawCompTrace( vars, time_begin, time_end )
%  eg. drawCompTrace( vars, 0, 0 )
%
%  vars - Ҫ���б����ı������ƣ����� getVars('') �õ�
%  inode - ��Ϊ�����ڵ�ͳ��ʱ�Ľڵ��±ꣻ0 Ϊ����ɸѡ
%  time_begin, time_end - ��ʼ������ʱ�䣻0 Ϊ����ɸѡ

function drawCompTrace( vars, time_begin, time_end )

    traces = {};
    comparisons = {};
    
    for i = 1:length(vars)
        
        model = evalin('base', vars{i});

        column_time = model(:, 1);
        columns_prediction = model(:, 2:3);
        columns_fact = model(:, 4:5);
        trace_prediction = horzcat(column_time, columns_prediction);
        trace_fact = horzcat(column_time, columns_fact);
        
        % collect all the traces to for motion range computation
%         trace = {};
%         trace{end + 1} = trace_prediction;
%         trace{end + 1} = trace_fact;
%         traces{end + 1} = trace;
        traces{end + 1} = trace_prediction;
        traces{end + 1} = trace_fact;

        % clip according to time limit
        
        rows = findRow( model(:, 1), time_begin, time_end );
        irow_begin = min(rows);
        irow_end = max(rows);

        comparison = {};
        trace_prediction_clipped = trace_prediction(irow_begin : irow_end, :);
        trace_fact_clipped = trace_fact(irow_begin : irow_end, :);
        comparison{end + 1} = trace_prediction_clipped;
        comparison{end + 1} = trace_fact_clipped;

        comparisons{end + 1} = comparison;
                
    end
        
    % draw a trace comparison for each var
    
    for i = 1:length(comparisons)
        
        comparison = comparisons{i};
        
        title = strcat(vars{i}, '-', int2str(time_begin), '-', int2str(time_end));
        figure('outerposition', get(0, 'screensize'), 'name', title);
        
        red = [1 0 0];
        green = [0 0.5 0];
        icolumn_x = 2;
        icolumn_y = 3;
        
        prediction = comparison{1};
        fact = comparison{2};
        
        plot(prediction(:,icolumn_x), prediction(:,icolumn_y), '-. .', 'color', red);
        hold on;
        plot(fact(:,icolumn_x), fact(:,icolumn_y), '- .', 'color', green);
    
        legend('prediction', 'fact', 'Location', 'NorthWest');
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
