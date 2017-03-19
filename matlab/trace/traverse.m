%  traverse( func, name_exceptions )
%  eg. traverse(@min, 'ans,x,y')
%
%  ���������ռ��е����ݣ�ִ�и���������
%  func - Ҫ�Ա�����ÿһ������ִ�еĺ������
%  name_exceptions - Ҫ�ų����ⲻ���б����ı������ƣ��ö��ŷָ�����Ӧ�ж���ո�

function traverse( func, name_exceptions )

    whos = evalin('base','who');
    whos = removeException(whos, name_exceptions);

    for i = 1:length(whos)   
		name = whos{i};
        mat = evalin('base', name);
        mat = func(mat);
		assignin('base', name, mat);
    end

end