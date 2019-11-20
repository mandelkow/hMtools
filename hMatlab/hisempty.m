function X = hisempty(varargin)
%[***1a++] Use hisempty(C{:}) to replace cellfun(@isempty,C).
% ALTERNATIVE: X = C==[] % using my own overloaded operator ==

% AUTHOR: Hendrik Mandelkow
% AUTH: HM, 2013-09

if nargin > 1,
    X = cellfun(@isempty,varargin);
else
    X = isempty(varargin{1});
end
