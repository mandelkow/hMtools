function [T,R] = hsystem(varargin)
% Execute SYSTEM and return cellstring.
% [T,R] = hsystem(Cmd,varargin)
% SEE ALSO: HSYSFIND

% AUTHOR: Hendrik Mandelkow, <2018

varargin(2,:) = {' '};
[R,T] = system([varargin{:}]);
% if R, error('%s\n%s',Cmd,T); end
% if strncmpi(T,'find:',5), error('%s\n%s',Cmd,T); end % Warnings
if ~isempty(T), T = textscan(T,'%s','delimiter','\n'); T = T{1}; end
