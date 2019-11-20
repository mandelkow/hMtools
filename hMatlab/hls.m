function F = hls(varargin)
%[**2a++] Directory (ls) with output as cellstring.
% F = textscan(ls(Str),'%s'); F = F{1};
% F = textscan(ls(varargin{:}),'%s');
try
	F = ls(varargin{:});
catch ERR
	if strfind(ERR.message,'No such file or directory'),
		warning('ls: File not found.');
		F = {};
		return
	else
		rethrow(ERR);
	end
end
F = textscan(F,'%s');
F = F{1};
