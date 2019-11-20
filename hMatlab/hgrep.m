function Fname = hgrep(Text,Path,File,Options)
%[**1a++] Fname = hgrep(Text,Path,File,Options)
%
% [~,Fname] = system(sprintf('grep -rl %s %s --include="%s" %s',...
% 	Options,Text,File,Path));
% Fname = textscan(Fname,'%s'); Fname = Fname{1};
%
% function hopentoregex(Fname,Pattern)
% [~,F] = system('grep -hnm1 Pattern Fname')
% Line = textscan('%n:',F{1}{1});
% opentoline(Fname,Line)

% AUTHOR: Hendrik Mandelkow

if nargin<2 || isempty(Path), Path = '*'; end
if nargin<3, File = ''; end
if nargin<4 || isempty(Options), Options = '-lr'; end

% cmd = 'grep -lr';
cmd = ['grep ',Options];
%< if strcmp(Text,lower(Text)), cmd = [cmd,'i']; end
% if ~isempty(File), cmd = sprintf('%s --include="%s"',cmd,File); end
if ~isempty(File),
	File = cellstr(File);
	cmd = [cmd,sprintf(' --include="%s"',File{:})];
end
%< if ~isempty(Options), cmd = [cmd,' ',Options]; end
cmd = sprintf('%s "%s" %s',cmd,Text,Path);

disp(cmd)
[s,Fname] = system(cmd);
% [s,Fname] = system(cmd,'-echo'); % TEST echo output
% if s, error(cmd); end % Stupidly, returns 1 on empty result?!?
if ~isempty(Fname),
    Fname = textscan(Fname,'%s','Delimiter','\n'); Fname = Fname{1};
end
