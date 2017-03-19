%  importFile( path, format, prefix )
%  eg. importFile( 'Statefair', '*.txt', 'Statefair_' )
%
%  给定路径、文件名要求，将文件中的数据导入工作空间，并添加可选的前缀。
%  path - 导入的 .trace 文件的目录名 '/$path/' ；
%  format - 导入文件名符合筛选格式的所有文件，如 '*.txt'；
%  prefix - 导入为矩阵变量时，变量将被命名为 'prefix + 文件名'；

function importFile(path, format, prefix)

	files = dir(fullfile(strcat(path, '\\'), format ));

	for ifile = 1:length(files)
		filename = strcat( path, '\\', files(ifile, 1).name );

		% Import the file
		rawData1 = importdata(filename);

		% For some simple files (such as a CSV or JPEG files), IMPORTDATA might
		% return a simple array.  If so, generate a structure so that the output
		% matches that from the Import Wizard.
		[~,name] = fileparts(filename);
		name = strcat(prefix, name);
		newData1.(genvarname(name)) = rawData1;

		% Create new variables in the base workspace from those fields.
		vars = fieldnames(newData1);
		for i = 1:length(vars)
			assignin('base', vars{i}, newData1.(vars{i}));
		end
	end

%  names = horzcat(x1(1:200,2:3),x2(1:200,2:3),x3(1:200,2:3))

end