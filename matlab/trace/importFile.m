%  importFile( path, format, prefix )
%  eg. importFile( 'Statefair', '*.txt', 'Statefair_' )
%
%  ����·�����ļ���Ҫ�󣬽��ļ��е����ݵ��빤���ռ䣬����ӿ�ѡ��ǰ׺��
%  path - ����� .trace �ļ���Ŀ¼�� '/$path/' ��
%  format - �����ļ�������ɸѡ��ʽ�������ļ����� '*.txt'��
%  prefix - ����Ϊ�������ʱ��������������Ϊ 'prefix + �ļ���'��

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