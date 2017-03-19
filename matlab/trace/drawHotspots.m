%  drawHotspots( fig, height, time_end )
%  eg. drawHotspots( drawBar( 'Statefair', 10, 20000 ) , 0, time_end )
%  
%  fig - �� fig ͼ�е��ӻ����ȵ�����
%  height - ��ʾ�ȵ������Բ�λ��Ƶĸ߶ȣ�
%  time_end - ���Ƹ�ʱ��ʱʹ�õ��ȵ㼯�ϣ� 0 ���Զ�ѡȡ���µ��ȵ㼯�ϣ�

function drawHotspots( fig, height, time_end )
%DRAWHOTSPOTS Summary of this function goes here
%   Detailed explanation goes here

    set(fig, 'active');
    hold on; 


    hotspots = evalin('base', 'hotspots');
    
%     % ��ʾ��Χ������ʱ����ȵ�
%     if( time_begin + time_end ~= 0 )
%         rows = find( time_begin <= hotspots(:,1) & hotspots(:,1) <= time_end);
%     else
%         rows = find( hotspots(:,1) );
%     end

    % ֻ��ʾ��Χ�ڵ����һ���ȵ�
    if( time_end ~= 0 )
        time_end = floor( time_end / 900 ) * 900;
        rows = find( hotspots(:,1) == time_end );
    else
        rows = find( hotspots(:,1) == max(hotspots(:,1)) );
    end
    row_start = min(rows);
    row_end = max(rows);

    for j = row_start : row_end
        alpha = 0 : pi / 50 : 2 * pi;  %�Ƕ� [ 0, 2 * pi ] 
        heights = zeros(1, length(alpha) );
        R = 100;  %�뾶 
        x = R * cos( alpha ) + hotspots(j, 2); 
        y = R * sin( alpha ) + hotspots(j, 3); 
        plot3(x, y, heights, '--', 'color', [ 0.24 0.57 0.25 ], 'LineWidth', 2);
        heights = heights + height;
        plot3(x, y, heights, '--', 'color', [ 0.24 0.57 0.25 ], 'LineWidth', 2);
        hold on;
    end


%     axis equal;
    hold off;

end

