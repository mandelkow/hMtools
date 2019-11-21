function [T,Cmd] = hsysfind(varargin)
%:**1a1+: Wrapper for Unix find, Fname{:} = hsysfind('command options...')

% AUTHOR: Hendrik Mandelkow, 2014-02
% AUTH: HM, 201507: Add warning - File not found.

% varargin = varargin(:).'; % = strjoin(varargin,' ')
% varargin(2,:) = {' '};
% Cmd = ['find -H ',varargin{:},' -nowarn'];
% Cmd = strjoin({'find -H',varargin{:},'-nowarn'});
Cmd = strjoin({'find',varargin{:},'-nowarn'},' ');
[R,T] = system(Cmd);
if R,
	if strfind(T,'No such file or directory'),
		warning('File not found.\n\t%s',Cmd);
		T = {};
		return;
	else
		error('%s\n%s',Cmd,T);
	end
end
if strncmpi(T,'find:',5), error('%s\n%s',Cmd,T); end % Warnings
if ~isempty(T), T = textscan(T,'%s','delimiter','\n'); T = T{1}; end
T(cellfun(@isempty,T)) = [];
