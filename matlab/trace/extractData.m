function [ data ] = extractData(mat)
	data = feval('getfield', mat, 'data');
end