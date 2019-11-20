function [C,L,I] = hstrfind(varargin)
% hStrFind = @(varargin) find(~cellfun(@isempty,strfind(varargin{:})));
% hStrFindRex = @(varargin) find(~cellfun(@isempty,regexp(varargin{:})));

%% AUTHOR: Hendrik Mandelkow

C = strfind(varargin{:});
if nargout<2, return; end
L = ~cellfun(@isempty,C);
if nargout<3, return; end
I = find(L);
