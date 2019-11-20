function S = hwhos(varargin)
%HWHOS [**1b] Alternaive layout for WHOS
% SEE ALSO: hwh, whos

% AUTHOR: Hendrik Mandelkow, 2015

S = evalin('caller','whos');
% S = evalin('caller',['whos',sprintf(' %s',varargin{:})]); % Error, buy why?
if nargout<1
	fprintf('\n\tNAME\tCLASS\tBYTES\tSIZE\n');
	for S=S(:)',
		for n={'global','complex'},
			n = n{1};
			if S.(n), S.(n)=n; else S.(n)=''; end
		end
		fprintf('\t%s \t%s \t%u \t[ %s\b]\n',...
			S.name, S.class, S.bytes, num2str(S.size,'%u '));
	end
	clear S
end
