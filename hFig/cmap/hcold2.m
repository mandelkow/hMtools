function cmap = hcold(varargin)
% Colormap

% AUTHOR: Hendrik Mandelkow, 2006-08-26

cmap = hhot(varargin{:});
cmap = cmap(:,[3,2,1]);
