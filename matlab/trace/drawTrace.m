%  [ fig ] = drawTrace( traces, title, line_marker, range )
%  eg. drawTrace(  traces, 'NCSU', '- .', [-10000, -15000, 10000, 5000] )
%
%  为给定的轨迹数据集绘制折线图。
%  fig - 返回图表句柄；
%  traces - 多个节点的轨迹数据，从 getTrace 函数得到
%  title - 图表标题；
%  line_marker - plot 函数中指示线型和标记符号的字符串，如 '- .' / ': +' / '-- *'；
%  range - 绘制区域的边界，单位为米，可通过 range 函数获取，e.g. [-10000, -15000, 10000, 5000]

function [ fig ] = drawTrace( traces, title, line_marker, range )

    figure('outerposition', get(0, 'screensize'), 'name', title);
    axis(range);
    
    colors = colormap(lines);
    column_x = 2;
    column_y = 3;

    for i = 1:length(traces)

        itrace = traces{i};

        color = colors(mod(i, length(colors)) + 1, :);
        plot(itrace(:,column_x), itrace(:,column_y), line_marker, 'color', color);
        hold on;
    end

    fig = gcf;

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

% v = evalin('base', 'var'); %把基本工作空间中的变量var的值赋给局部变量v。
% 
% v = evalin('base', 'who'); %查询基本工作空间中的变量名称，并把变量名称保存到v数组中；举例：调用基本工作空间中的变量来在界面上绘制图形。
