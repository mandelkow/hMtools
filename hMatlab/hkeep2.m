function W = hkeep(varargin)
%hkeep2(var1,var2,...) clear all variables except var1, var2
% (Input variables not strings.)
%
% SEE ALSO: hkeep (for_string_input 'var1','var2',...)

% AUTHOR: Hendrik Mandelkow

W = evalin('caller','who');
if isempty(W), return; end

for n=1:nargin,
    varargin{n} = inputname(n);
    W(strcmp(varargin{n},W)) = [];
end

if nargout < 1,
    W = sprintf('%s ',varargin{:});
    evalin('caller','clear %s',W);
end
