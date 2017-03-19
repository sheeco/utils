%  traverse( func, name_exceptions )
%  eg. traverse(@min, 'ans,x,y')
%
%  遍历工作空间中的数据，执行给定操作。
%  func - 要对遍历的每一个变量执行的函数句柄
%  name_exceptions - 要排除在外不进行遍历的变量名称，用逗号分隔，不应有多余空格

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