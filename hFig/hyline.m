function Hdl = hyline(Y, varargin)
% [****1a] Add horizontal lines to current axes.
%
% USAGE:	Hdl = hyline(Y,varargin)
%
%			Y = Vector of vertical positions of lines in data units.
%			varargin = list of line property & value pairs to be set for all lines.
%
%			Hdl = Vector of handles to the lines drawn.
%
% hyline = @(Y,varargin) plot((xlim).',[1;1]*Y(:).',varargin{:})
%
% SEE ALSO: hxline, hyline, hvline, hcolstyle

% AUTHOR: Hendrik Mandelkow, 2018
% AUTH: HM, 2018-10-11, v.1a

hold on
Hdl = plot((xlim).',[1;1]*Y(:).',varargin{:}); % Matlab 2018!
