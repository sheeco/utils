%  [ ret ] = removeException( names, name_exceptions )
%  eg. whos = removeException( whos, '001,002' )
%
%  从给定的 cell 中排除部分字符串。
%  names - 由字符串组成的 cell
%  name_exceptions - 要排除在外的字符串，用逗号分隔，不应有多余空格，e.g. 'ans,info,freq'

function [ ret ] = removeException( names, name_exceptions )

    str = deblank(name_exceptions);
    exceptions = regexp(str, ',', 'split');

    ret = {};
    for i = 1:length(names)
        skip = 0;
        for i_exception = 1 : length(exceptions)
            if( strcmp( names{i}, char(exceptions(i_exception)) ) )
                skip = 1;
                break;
            end
        end
        
        if( skip == 0 )
            ret{end+1} = names{i};
        end
    end

end

% 
% 以下面这样一串字符为例
% 
% Hello Nocturne Studio
% 
% 首先去除首尾的多余空格：
% str = deblank(str)
% 
% 例1：设这几个字符串是以制表符分隔的，可以这样来做：
% S = regexp(str, '\t', 'split')
% 
% 例2：设这些字符串是以一个或多个空格分隔的，可以用正则表达式来描述：
% S = regexp(str, '\s+', 'split')
% 
% 这样，S(1)=’Hello’，S(2)=’Nocturne’，S(3)=’Studio’。
% 
% 注意，上面得到的结果S是一个cell型变量，它的每个元素比如S(1)仍然是cell型的，只能用来display，不能直接用来进行字符串操作（比如获取其中的某个字符），所以我们在使用需要执行一次：
% s1 = char(S(1))
% 
% 这样的s1才是一个真正的字符串，可以进行后续的操作。
