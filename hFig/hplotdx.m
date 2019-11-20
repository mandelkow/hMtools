function [H,x] = hplotdx(y,x,varargin)
%[***3a++] Create xdata and plot ydata.
%
% [H,x] = hplotdx(y,dx,varargin) % varargin is passed to plot
% [H,x] = hplotdx(y,[x0,dx],varargin)
%
% EXAMPLE: Line = hplotdx(randn(10,1),.1,'r--') % = plot([0:9].*0.1,randn(10,1));
%
% hplotdx = @(Y,dx,varargin) plot([0:length(y)-1].*dx, Y, varargin{:})
% hplotdx0 = @(Y,dx,varargin) plot([0:length(y)-1].*dx(2)+dx(1), Y, varargin{:})
%
% SEE ALSO: PLOT, hxdata

% AUTHOR: Hendrik Mandelkow, 2000
% AUTH: HM 2000, ver.1a.
% AUTH: HM 23.10.2003, ver.2a.
% AUTH: HM, 2012-02, v.3a: Add output t and help.

y = shiftdim(y);    % remove leading singletons.

if nargin<2 || isempty(x), x = [0 1]; end
if numel(x) < 2, x = [0 x(1)]; end
x = x(1) + x(2)*[0:size(y,1)-1]';
H = plot(x,y,varargin{:});
