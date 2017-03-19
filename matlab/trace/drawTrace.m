%  [ fig ] = drawTrace( traces, title, line_marker, range )
%  eg. drawTrace(  traces, 'NCSU', '- .', [-10000, -15000, 10000, 5000] )
%
%  Ϊ�����Ĺ켣���ݼ���������ͼ��
%  fig - ����ͼ������
%  traces - ����ڵ�Ĺ켣���ݣ��� getTrace �����õ�
%  title - ͼ����⣻
%  line_marker - plot ������ָʾ���ͺͱ�Ƿ��ŵ��ַ������� '- .' / ': +' / '-- *'��
%  range - ��������ı߽磬��λΪ�ף���ͨ�� range ������ȡ��e.g. [-10000, -15000, 10000, 5000]

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

% v = evalin('base', 'var'); %�ѻ��������ռ��еı���var��ֵ�����ֲ�����v��
% 
% v = evalin('base', 'who'); %��ѯ���������ռ��еı������ƣ����ѱ������Ʊ��浽v�����У����������û��������ռ��еı������ڽ����ϻ���ͼ�Ρ�
