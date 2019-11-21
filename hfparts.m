function [P,F,E,C] = hfparts(DirFileExt,N)
% [**1b++] Cell array of file name parts.
% [Path/, Fname, Ext, CellArray] = hfparts(DirFileExt,N)
% C{:} = hfparts(DirFileExt,N), FullFile = [C{:}]
% SEE ALSO: hFileParts()

% AUTHOR: Hendrik Mandelkow, 2015-08, v1a

% (0|1)*(sth ending in /) + (1|more)*(anything except ./\) + (0|1)*(.+sth)
P = regexp(cellstr(DirFileExt),'(.*[/\\])?(\.?[^\./\\]+)(\..*)?','tokens');
% ??? P = regexp(DirFileExt,'([^\./\\]*[\./\\])*','tokens');
% P{strings}{matches}{tokens}
P = cat(1,P{:});
for n=1:size(P,1)
    P{n}{1} = regexp(P{n}{1},'([^/\\]*[/\\]?)','tokens');
    % P{n}{1} = regexp(P{n}{1},'[^/\\]*[/\\]?','match');
    P{n} = cat(2,P{n}{1}{:},P{n}{2:3});
end
% P = cat(2,P{:});
if nargin > 1,
    N(N<1) = N(N<1)+numel(P); % 0 = end, Should be -1?!
    N(N>numel(P)) = []; % could throw error?!
    P = [P{N}];
end
if nargout > 1,
    F = P(end-1:end);
    P(end-1:end) = [];
end
if nargout > 2,
    E = F(end);
    F(end) = [];
end
