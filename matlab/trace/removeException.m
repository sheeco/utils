%  [ ret ] = removeException( names, name_exceptions )
%  eg. whos = removeException( whos, '001,002' )
%
%  �Ӹ����� cell ���ų������ַ�����
%  names - ���ַ�����ɵ� cell
%  name_exceptions - Ҫ�ų�������ַ������ö��ŷָ�����Ӧ�ж���ո�e.g. 'ans,info,freq'

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
% ����������һ���ַ�Ϊ��
% 
% Hello Nocturne Studio
% 
% ����ȥ����β�Ķ���ո�
% str = deblank(str)
% 
% ��1�����⼸���ַ��������Ʊ���ָ��ģ���������������
% S = regexp(str, '\t', 'split')
% 
% ��2������Щ�ַ�������һ�������ո�ָ��ģ�������������ʽ��������
% S = regexp(str, '\s+', 'split')
% 
% ������S(1)=��Hello����S(2)=��Nocturne����S(3)=��Studio����
% 
% ע�⣬����õ��Ľ��S��һ��cell�ͱ���������ÿ��Ԫ�ر���S(1)��Ȼ��cell�͵ģ�ֻ������display������ֱ�����������ַ��������������ȡ���е�ĳ���ַ���������������ʹ����Ҫִ��һ�Σ�
% s1 = char(S(1))
% 
% ������s1����һ���������ַ��������Խ��к����Ĳ�����
