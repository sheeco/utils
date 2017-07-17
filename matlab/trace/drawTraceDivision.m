%  [ fig ] = drawTraceDivision( name, trace, division, line_marker, motion_range )
%  eg. drawTraceDivision(  'node#01', x01, 0.5, '- .', [-10000, -15000, 10000, 5000] )
%
%  Ϊ�����ڵ�켣�����ո����Ļ��ֱ����ֱ����ѵ�����Ͳ��Լ�������ͼ��
%  fig - ����ͼ����
%  name - ͼ�����
%  trace - �����ڵ�Ĺ켣���ݣ��� getTrace �����õ�
%  division - ѵ�����ı���/����
%  line_marker - plot ������ָʾ���ͺͱ�Ƿ��ŵ��ַ������� '- .' / ': +' / '-- *'

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