%  drawCompTrace( vars, time_begin, time_end )
%  eg. drawCompTrace( vars, 0, 0 )
%
%  vars - Ҫ���б����ı������ƣ����� getVars('') �õ�
%  inode - ��Ϊ�����ڵ�ͳ��ʱ�Ľڵ��±ꣻ0 Ϊ����ɸѡ
%  time_begin, time_end - ��ʼ������ʱ�䣻0 Ϊ����ɸѡ

function drawHit( var, limit )

    deviations = [];
    
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

    model = evalin('base', var);

    column_time = model(:, 1);
    columns_prediction = model(:, 2:3);
    columns_fact = model(:, 4:5);
    columns_difference = columns_prediction - columns_fact;
    column_deviation = (columns_difference(:, 1).^2 + columns_difference(:, 2).^2).^(1/2);
    deviations = vertcat(deviations, column_deviation);
        
    rows_hits = find( deviations <= limit );
    num = length(deviations);
    
    hit_rate = length(rows_hits) / num;
    hit_rate = num2str(hit_rate);
    
    max_ = max(deviations);
    ceil_ = ceil(max_ / limit) * limit;
    
    edges = [0:limit:ceil_];
    N = histc(deviations, edges);
    N = N / num;
    
    figure('outerposition', get(0, 'screensize'), 'name', [var, ':hitrate=', hit_rate]);
    bar(N);
    
    set(gca, 'xLim', [0, length(edges)]);
    set(gca, 'xTick', [0:1:length(edges)]);
    set(gca, 'xTickLabel', edges);

%     for i = 1:length(N) 
%         text(i, N(i), num2str(N(i)), 'FontSize', 8, 'horiz','center','vert','top') 
%     end
    

end
