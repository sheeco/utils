%  [ ret ] = makeName(name, underline)
%  eg. name = makeName(name, 1)
%
%  name - ��ת�����ַ���
%  underline - �Ƿ������»���

function [ ret ] = makeName(name, underline)

    if underline
    	ret = strrep(name, '-', '_');
    else
    	ret = strrep(name, '_', '-');
    end        

end