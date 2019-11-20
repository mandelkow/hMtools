function map = hcold(m)
% Colormap

% AUTHOR: Hendrik Mandelkow, 2004-09-23

if nargin < 1,
  m = length(colormap);
end;

map = hot(m);
map = map(:,[2 1 3]);
