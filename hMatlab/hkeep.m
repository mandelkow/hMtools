function W = hkeep(varargin)
%HKEEP [*1a++] Clear all but a few variables.
%
% Vars = hkeep('var1','var2',...);
% hkeep('var1','var2',...) % clear all but var1, var2,...
%
% Simpler: tmp = setdiff(who,{'var1','var2',...}); clear(tmp{:})

% AUTHOR: Hendrik Mandelkow

W = evalin('caller','who');
if isempty(W), return; end

% W = setdiff(W,varargin); % better!
for n=1:nargin,
    W{strcmp(varargin{n},W)} = [];
end
W(cellfun('isempty',W)) = [];

if any(~cellfun('isclass',W,'char')),
    error('Input must be char!');
end

if nargout < 1,
    % fprintf('%s ',W{:})
    evalin('caller',['clear',sprintf(' %s',W{:})]);
    clear W
end
