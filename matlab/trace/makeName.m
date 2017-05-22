%  [ ret ] = makeName(name, underline)
%  eg. name = makeName(name, 1)
%
%  name - 待转换的字符串
%  underline - 是否允许下划线

function [ ret ] = makeName(name, underline)

    if underline
    	ret = strrep(name, '-', '_');
    else
    	ret = strrep(name, '_', '-');
    end        

end