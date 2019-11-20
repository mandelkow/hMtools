function [K,L] = hstrfind(varargin)
% hStrFind = @(varargin) find(~cellfun(@isempty,strfind(varargin{:})));
% hStrFindRex = @(varargin) find(~cellfun(@isempty,regexp(varargin{:})));

K = regexp(varargin{:});
L = find(~cellfun(@isempty,K));
