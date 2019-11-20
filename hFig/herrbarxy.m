function h = herrbarxy(x,y,varargin)
%[**1A++] Plot errorbars in xy (as single line).
%
% h = herrbar(x(:)+[-dx,0,dx],y(:)+[-dy,0,dy],[LineSpec])
%
% SEE ALSO: herrbar, herrbart (T-bars), herrbarx, herrbarxt

% AUTHOR: Hendrik Mandelkow, 2016-04

x = x(:,[1 3 2 2 2 2]).'; x([3 6],:) = nan;
y = y(:,[2 2 2 1 3 2]).'; y([3 6],:) = nan;
hold on;
h = plot(x(:),y(:),varargin{:});
