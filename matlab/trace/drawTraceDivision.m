%  [ fig ] = drawTraceDivision( name, trace, division, line_marker, motion_range )
%  eg. drawTraceDivision(  'node#01', x01, 0.5, '- .', [-10000, -15000, 10000, 5000] )
%
%  为单个节点轨迹，按照给定的划分比例分别绘制训练集和测试集的折线图。
%  fig - 返回图表句柄
%  name - 图表标题
%  trace - 单个节点的轨迹数据，从 getTrace 函数得到
%  division - 训练集的比例/长度
%  line_marker - plot 函数中指示线型和标记符号的字符串，如 '- .' / ': +' / '-- *'

function [ fig ] = drawTraceDivision( name, trace, division, line_marker )

    figure();
    set(gcf, 'name', name);
    
    colors = colormap(lines);
    column_x = 2;
    column_y = 3;
    
    motion_range = getRange({trace}, 100);
    
    len = size(trace, 1);
    if division < 1
        train = len * division;
    else 
        train = division;
    end
    
    trainset = trace(1:train, :);
    testset = trace(train:end, :);

    subplot(2, 1, 1);
    color = colors(1, :);
    plot(trainset(:,column_x), trainset(:,column_y), line_marker, 'color', color);
    axis(motion_range);
    title(['trainset: ', num2str(1), '-', num2str(train)]);

    subplot(2, 1, 2);    
    color = colors(2, :);
    plot(testset(:,column_x), testset(:,column_y), line_marker, 'color', color);
    axis(motion_range);
    title(['testset: ', num2str(train), '-', num2str(len)]);

    fig = gcf;

end