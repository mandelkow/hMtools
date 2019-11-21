function [Dir,File,Ext,All,Check] = hfileparts(DirFileExt,N)
%HFILEPARTS :2A: [Dir,File,Ext,All,Check] = hfileparts(DirFileExt,N)
%
% hFileExt = @(F) regexprep(F,'.+\.(\w*)$','$1');
%
% SEE ALSO: hFparts()

% AUTHOR: Hendrik Mandelkow, 2017-01-10, v2a

% (0|1)*(sth ending in /) + (1|more)*(anything except ./\) + (0|1)*(.+sth)
P = regexp(DirFileExt,'(.*[/\\])?([^\./\\]+)(\..*)?','tokens');
if nargin < 2,
    [Dir,File,Ext] = deal(P{1}{:});
% elseif iscell(N),
%     N = N{1};
%     Dir = deal(tmp{1}{N});
%     Dir ...
else
    Dir = deal(P{1}{N});
end
if nargout > 3,
    if isempty(Dir), Dir = [pwd,filesep]; end
    All = [Dir,File,Ext];
end
if nargout > 4,
    Check = exist(All,'file');
end
