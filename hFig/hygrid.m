function Hdl = hygrid(y, varargin)
% [***1a] Add y lines to current axes.
%
% USAGE:	Hdl = hxline(X,varargin)
%
%			X = Vector of horizontal positions of lines in data units.
%			varargin = list of line property & value pairs to be set for all lines.
%
%			Hdl = Vector of handles to the lines drawn.
%
% hxline = @(X,varargin) plot([1;1]*X(:).',(ylim).',varargin{:})
%
% SEE ALSO: hxline, hyline, hvline, hcolstyle, hxgrid, hygrid, herrbar*

% AUTHOR: Hendrik Mandelkow, 2018
% AUTH: HM, 2018-10-11, v.1a

if nargin<2, varargin{1} = 'k--'; end
x = repmat([xlim, nan].',1,numel(y));
y = [1;1;nan] .* y(:).';
hold on
Hdl = plot(x(:),y(:),varargin{:});
